import 'package:flutter/material.dart';
import 'package:fanki/app.dart';
import 'router.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

// ignore: non_constant_identifier_names
final NEXT_PUBLIC_SUPABASE_URL = 'https://nboagoifuwsecqjhxrop.supabase.co';
// ignore: non_constant_identifier_names
final NEXT_PUBLIC_SUPABASE_ANON_KEY =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5ib2Fnb2lmdXdzZWNxamh4cm9wIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk3MTgzNzEsImV4cCI6MjA1NTI5NDM3MX0.fhfasszFIKAnFExFqkjgXj5G5FxRVB3duAaymzWY_QM';
// final supabase = Supabase.instance.client;

Future<void> main() async {
  await Supabase.initialize(
    url: NEXT_PUBLIC_SUPABASE_URL,
    anonKey: NEXT_PUBLIC_SUPABASE_ANON_KEY,
  );

  runApp(
    FankiApp(router: router),
  );
}
