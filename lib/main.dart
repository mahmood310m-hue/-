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
        primaryColor: const Color(0xFF1E40AF), // أزرق هادئ
        scaffoldBackgroundColor: const Color(0xFFF8FAFC), // خلفية ناعمة لراحة العين
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E40AF),
          secondary: const Color(0xFFF59E0B), // ذهبي دافئ
        ),
        useMaterial3: true,
      ),
      home: const MainHomePage(),
    );
  }
}

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _currentIndex = 3; // تبويب الرئيسية مفعل افتراضياً (حسب الترتيب من اليمين)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الهيدر العلوي (الترحيب والعنوان)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)
                          ],
                        ),
                        child: const Icon(Icons.settings, color: Color(0xFF1E40AF)),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.language, size: 18, color: Color(0xFF1E40AF)),
                            SizedBox(width: 5),
                            Text('العربية', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'الرئيسية',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                      ),
                      Text(
                        'مرحباً بك، ابدأ رحلتك المدرسية اليوم',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // البطاقة الكبيرة البارزة في الأعلى (Banner)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFEF3C7), Color(0xFFFDE68A)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'مدرسة كوثر الأهلية',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF92400E)),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'متابعة المواد الدراسية والجداول اليومية\nخطوة بخطوة نحو التفوق والنجاح',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 13, color: Color(0xFF78350F), height: 1.5),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD97706),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('متابعة آخر درس'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // عنوان قسم أقسام التعلم
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'اختر ما تريد متابعته اليوم',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'أقسام المدرسة',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // شبكة البطاقات (Grid Cards) بتصميم مشابه للصورة تماماً
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.95,
                children: [
                  _buildSchoolCard(
                    title: 'جدول الحصص',
                    subtitle: 'الحصص اليومية\nالمواعيد القادمة\nتوزيع القاعات',
                    color: const Color(0xFF3B82F6),
                    icon: Icons.calendar_month_rounded,
                  ),
                  _buildSchoolCard(
                    title: 'الواجبات اليومية',
                    subtitle: 'الواجبات المطلوبة\nتسليم التمارين\nمتابعة المعلمين',
                    color: const Color(0xFF10B981),
                    icon: Icons.book_rounded,
                  ),
                  _buildSchoolCard(
                    title: 'النتائج الشهرية',
                    subtitle: 'اختبارات المفردات\nاختبارات القواعد\nتقييم المستوى',
                    color: const Color(0xFFD97706),
                    icon: Icons.bar_chart_rounded,
                  ),
                  _buildSchoolCard(
                    title: 'الرسوم المدرسية',
                    subtitle: 'المدفوعات المالية\nالأقساط المتبقية\nالإيصالات',
                    color: const Color(0xFFEC4899),
                    icon: Icons.payment_rounded,
                  ),
                  _buildSchoolCard(
                    title: 'الامتحانات',
                    subtitle: 'جدول الاختبارات\nنتائج الامتحانات\nمواعيد المراجعة',
                    color: const Color(0xFF8B5CF6),
                    icon: Icons.assignment_turned_in_rounded,
                  ),
                  _buildSchoolCard(
                    title: 'الإنجازات والتقارير',
                    subtitle: 'عدد الدروس المكتملة\nنقاط التميز\nالشارات التقديرية',
                    color: const Color(0xFFF59E0B),
                    icon: Icons.emoji_events_rounded,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // القائمة السفلية (Bottom Navigation Bar) المطابقة تماماً للصورة
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF1E40AF),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'الحساب',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: 'الامتحانات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: 'الدروس',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
        ],
      ),
    );
  }

  // دالة بناء البطاقات بتصميم منسق وأنيق
  Widget _buildSchoolCard({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.12),
                radius: 20,
                child: Icon(icon, color: color, size: 22),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
              ),
            ],
          ),
          Text(
            subtitle,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 11, color: Colors.grey, height: 1.3),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 25),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back_ios, size: 10, color: color),
                  const SizedBox(width: 4),
                  Text('فتح', style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
