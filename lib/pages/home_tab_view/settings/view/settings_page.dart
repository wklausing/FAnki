import 'package:fanki/blocs/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutPressed()),
            child: const Text('Ausloggen'),
          ),
        ],
      ),
    );
  }
}
