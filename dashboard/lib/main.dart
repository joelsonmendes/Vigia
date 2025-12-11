import 'package:flutter/material.dart';
import 'package:vigia_dashboard/screens/individual_view_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vigia Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const IndividualViewScreen(
        studentName: "João Silva",
        courseId: "Mecânica 2024",
      ),
    );
  }
}