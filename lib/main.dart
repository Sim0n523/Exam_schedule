import 'package:flutter/material.dart';
import 'models/exam.dart';
import 'widgets/exam_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Распоред на испити',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Exam> exams = [
    Exam(title: 'Калкулус', dateTime: DateTime.now().subtract(const Duration(days: 5)), rooms: ['138', '215', '117', '13', '2', '3']),
    Exam(title: 'Структурно Програмирање', dateTime: DateTime.now().add(const Duration(days: 2)), rooms: ['315', 'Барака 2.2', 'Барака 3.2']),
    Exam(title: 'Дискретна математика', dateTime: DateTime.now().add(const Duration(days: 5)), rooms: ['215', '117']),
    Exam(title: 'Алгоритми и податочни структури', dateTime: DateTime.now().subtract(const Duration(days: 2)), rooms: ['138, 117']),
    Exam(title: 'Веројатност и статистика', dateTime: DateTime.now().add(const Duration(days: 10)), rooms: ['315', 'Амф ФИНКИ Г']),
    Exam(title: 'Вештачка интелигенција', dateTime: DateTime.now().add(const Duration(days: 1)), rooms: ['117']),
    Exam(title: 'Вовед во наука за податоци', dateTime: DateTime.now().add(const Duration(days: 3)), rooms: ['215', '138']),
    Exam(title: 'Бази на податоци', dateTime: DateTime.now().subtract(const Duration(days: 7)), rooms: ['138', '117', '215']),
    Exam(title: 'Програмирање на видео игри', dateTime: DateTime.now().add(const Duration(days: 6)), rooms: ['2', '3']),
    Exam(title: 'Мобилни информациски системи', dateTime: DateTime.now().add(const Duration(days: 4)), rooms: ['138', '13']),
  ];

  @override
  Widget build(BuildContext context) {
    exams.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 4,
        title: const Text(
          'Распоред за испити',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 0.8,
            shadows: [
              Shadow(
                color: Colors.black38,
                offset: Offset(1, 1),
                blurRadius: 3,
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: exams.length,
        itemBuilder: (context, index) => ExamCard(exam: exams[index]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          'Вкупно испити: ${exams.length}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
