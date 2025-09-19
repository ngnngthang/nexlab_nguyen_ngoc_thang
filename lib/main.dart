import 'package:flutter/material.dart';
import 'package:nguyen_ngoc_thang_nexlab/features/login/view/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nguyen Ngoc Thang Test Nexlab',
      home: LoginScreen(),
    );
  }
}
