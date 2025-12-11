import 'package:flutter/material.dart';
import 'package:vigia_app/screens/consent_screen.dart';
import 'package:vigia_app/screens/home_screen.dart';
import 'package:vigia_app/screens/qr_link_screen.dart';
import 'package:vigia_app/themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vigia - SENAI',
      theme: AppTheme.darkTheme,
      initialRoute: '/consent',
      routes: {
        '/consent': (context) => const ConsentScreen(),
        '/home': (context) => const HomeScreen(),
        '/qr-link': (context) => const QRLinkScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}