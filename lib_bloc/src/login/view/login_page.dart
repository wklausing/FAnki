import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login_cubit.dart';
import 'login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationRepository login =
        RepositoryProvider.of<AuthenticationRepository>(context);
    return BlocProvider(
      create: (_) => LoginCubit(login),
      child: LoginView(),
    );
  }
}
