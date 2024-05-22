import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/login_cubit.dart';
import '../../learning/view/learning_page.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextStyle hintStyle = TextStyle(
      color: Colors.grey.shade400,
    );

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LearningPage()),
          );
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          String userID = context.read<LoginCubit>().userLoggedIn();
          if (state is LoginLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LoginSuccess) {
            _emailController.clear();
            _passwordController.clear();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('Du bist eingeloggt mit $userID.')),
                ElevatedButton(
                  onPressed: () {
                    context.read<LoginCubit>().logout();
                  },
                  child: Text('Ausloggen'),
                ),
              ],
            );
          } else if (state is LoginFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Einloggen fehlgeschlagen: ${state.error}',
                      style: TextStyle(color: Colors.red)),
                  _buildLoginForm(context, hintStyle),
                ],
              ),
            );
          } else {
            return _buildLoginForm(context, hintStyle);
          }
        },
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, TextStyle hintStyle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: hintStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Passwort',
                hintStyle: hintStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty) {
                  context
                      .read<LoginCubit>()
                      .login(_emailController.text, _passwordController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Login', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
