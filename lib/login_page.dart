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
      log.info("Authenticated successfully!");
    } on FirebaseAuthException catch (e) {
      log.info("Failed to authenticate: ${e.message}");
      throw Exception('Failed to authenticate: ${e.message}');
    }
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null) {
            return notSignedIn();
          } else {
            return signedIn(snapshot.data);
          }
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget signedIn(User? user) {
    String email = user!.email ?? 'NoUsername';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Signed in with: $email'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signOut,
              child: const Text('Sign out'),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget notSignedIn() {
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
              child: const Text('Sign in'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
