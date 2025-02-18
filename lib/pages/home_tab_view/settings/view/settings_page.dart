import 'package:fanki/app.dart';
import 'package:fanki/blocs/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.light_mode,
                  color: isDarkMode ? Colors.grey : Colors.amber),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  ThemeMode newThemeMode =
                      value ? ThemeMode.dark : ThemeMode.light;
                  MyApp.of(context).changeTheme(newThemeMode);
                },
              ),
              Icon(Icons.dark_mode,
                  color: isDarkMode ? Colors.blue : Colors.grey),
            ],
          ),
          SizedBox(
            height: 50,
          ),
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
