import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anki_app/main.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInIfCorrect(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log.info('Authenticated successfully!');
    } on FirebaseAuthException catch (e) {
      log.info('Failed to authenticate: ${e.message}');
      throw Exception('Failed to authenticate: ${e.message}');
    }
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final Stream<User?> userStream =
      FirebaseAuth.instance.authStateChanges();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _signIn() async {
    try {
      await _authService.signInIfCorrect(
          _emailController.text, _passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Widget _signedIn(User? user) {
    String email = user!.email ?? 'NoUsername';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Eingeloggt mit: $email'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signOut,
              child: const Text('Ausloggen'),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget _notSignedIn() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTextField(_emailController, 'Email'),
            SizedBox(height: 30),
            _buildTextField(_passwordController, 'Password'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Einloggen'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          border: const OutlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null) {
            return _notSignedIn();
          } else {
            return _signedIn(snapshot.data);
          }
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
