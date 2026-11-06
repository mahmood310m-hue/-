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
      title: 'Kawtar School',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SettingsPage(),
    );
  }
}

// صفحة الإعدادات الرئيسية
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.star, color: Colors.amber),
            title: const Text('الطلاب المتفوقون'),
            subtitle: const Text('عرض قائمة الطلاب المتفوقين'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HonorStudentsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// شاشة الطلاب المتفوقين
class HonorStudentsScreen extends StatelessWidget {
  const HonorStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الطلاب المتفوقون'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          'مرحباً بك في شاشة الطلاب المتفوقين',
          style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
