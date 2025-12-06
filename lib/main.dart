import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'theme.dart';

void main() {
  runApp(const ReremartApp());
}

class ReremartApp extends StatelessWidget {
  const ReremartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Inventaris Buku Reremart",
      theme: brownTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
