import 'package:flutter/material.dart';

class HonorStudentsScreen extends StatelessWidget {
  const HonorStudentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // قائمة تجريبية للطلاب المتفوقين (يمكن ربطها لاحقاً بقاعدة البيانات)
    final List> topStudents = [
      {'name': 'أحمد علي', 'grade': 'السادس الابتدائي', 'percentage': '99%', 'badge': 'الأول على المدرسة'},
      {'name': 'فاطمة حسن', 'grade': 'السادس الابتدائي', 'percentage': '98.5%', 'badge': 'الثاني على المدرسة'},
      {'name': 'محمد خالد', 'grade': 'الخامس الابتدائي', 'percentage': '97.8%', 'badge': 'الثالث مكرر'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة شرف المتفوقين'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: topStudents.length,
        itemBuilder: (context, index) {
          final student = topStudents[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0), // حواف محددة ونظيفة
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // أيقونة أو مكان لصورة الطالب
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.amber.shade200),
                  ),
                  child: const Icon(Icons.military_tech, color: Colors.amber, size: 28),
                ),
                const SizedBox(width: 16),
                // تفاصيل الطالب
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'الصف: ${student['grade']}',
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'الوسام: ${student['badge']}',
                        style: TextStyle(fontSize: 12, color: Colors.blue.shade700, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                // المعدل أو النسبة
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Text(
                    student['percentage']!,
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
