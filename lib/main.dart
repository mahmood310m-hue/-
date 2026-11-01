import 'package:flutter/material.dart';

void main() {
  runApp(const KawtarSchoolApp());
}

class KawtarSchoolApp extends StatelessWidget {
  const KawtarSchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مدرسة كوثر الأهلية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // اللون الأساسي: أزرق سماوي هادئ
        primaryColor: const Color(0xFF1E40AF),
        // خلفية الشاشات: أبيض رمادي ناعم لراحة العين
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E40AF),
          secondary: const Color(0xFFF59E0B), // ذهبي دافئ
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مدرسة كوثر الأهلية'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_rounded,
              size: 80,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 16),
            const Text(
              'أهلاً بكم في تطبيق مدرسة كوثر الأهلية',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
