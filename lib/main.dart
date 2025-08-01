import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'presentation/pages/login_page.dart';

void main() {
  runApp(const RescuePangApp());
}

class RescuePangApp extends StatelessWidget {
  const RescuePangApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RescuePang',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: const LoginPage(),
    );
  }
}
