import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login_cubit.dart';
import 'login_view.dart';

enum Difficulty { repeat, hard, good, easy }

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(LoginState(answerIsVisible: false)),
      child: LoginView(),
    );
  }
}
