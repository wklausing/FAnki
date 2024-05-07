// import 'package:anki_app/main.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';

// import 'dart:convert';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> signInIfCorrect(String email, String password) async {
//     // Map<String, dynamic> auth = await loadJsonFile();
//     // email = auth['email'];
//     // password = auth['password'];

//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       log.info("Authenticated successfully!");
//     } on FirebaseAuthException catch (e) {
//       log.info("Failed to authenticate: ${e.message}");
//     }
//   }

//   Future<Map<String, dynamic>> loadJsonFile() async {
//     try {
//       final contents = await rootBundle.loadString('assets/auth.json');
//       Map<String, dynamic> jsonData = json.decode(contents);
//       return jsonData;
//     } catch (e) {
//       print('Error reading or parsing the JSON file: $e');
//       return {};
//     }
//   }
// }
