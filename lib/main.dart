import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // The AppBar gives the app a standard look
        appBar: AppBar(
          title: const Text('Centered Button App'),
          backgroundColor: Colors.blue,
        ),
        // Center widget aligns its child to the middle of the screen
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // This code runs when the button is clicked
              print('Button Pressed!');
            },
            child: const Text('Click Me'),
          ),
        ),
      ),
    );
  }
}
