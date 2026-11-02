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
        primaryColor: const Color(0xFF1E40AF),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E40AF),
          secondary: const Color(0xFFF59E0B),
        ),
        useMaterial3: true,
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 3; // التبويب الافتراضي: الرئيسية

  // الصفحات الرئيسية المرتبطة بالشريط السفلي
  final List<Widget> _pages = [
    const ProfilePage(),
    const ResultsPage(),
    const HomeworkPage(),
    const DashboardTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
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
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'نتائجي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: 'واجباتي',
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
}

// --- 1. الشاشة الرئيسية (Dashboard) ---
class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.settings, color: Color(0xFF1E40AF)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
                    },
                  ),
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
                    'مرحباً بك في بوابة مدرسة كوثر',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // البانر الترويجي الأكبر
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
                  'بوابتك لكل شيء مدرسي',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF92400E)),
                ),
                const SizedBox(height: 8),
                const Text(
                  'تصفح جداولك، واجباتك، نتائجك، وإنجازاتك بكل يسر.',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 13, color: Color(0xFF78350F)),
                ),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SchedulePage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD97706),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  icon: const Icon(Icons.calendar_today_rounded),
                  label: const Text('استعراض الجدول الدراسي'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),

          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('اختر ما تريد مراجعته اليوم', style: TextStyle(fontSize: 12, color: Colors.grey)),
              SizedBox(width: 8),
              Text('أقسام المدرسة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            ],
          ),
          const SizedBox(height: 15),

          // شبكة البطاقات المفعلة بالكامل
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.95,
            children: [
              _buildSchoolCard(
                title: 'جداولي',
                subtitle: 'استعراض الحصص اليومية والتنبيهات',
                color: const Color(0xFF3B82F6),
                icon: Icons.calendar_month_rounded,
                btnText: 'عرض الجدول',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SchedulePage())),
              ),
              _buildSchoolCard(
                title: 'واجباتي',
                subtitle: 'الواجبات المطلوبة لهذا اليوم ومراجعتها',
                color: const Color(0xFF10B981),
                icon: Icons.assignment_rounded,
                btnText: 'مراجعة الواجب',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeworkPage())),
              ),
              _buildSchoolCard(
                title: 'إشعاراتي',
                subtitle: 'آخر الإعلانات المدرسية والرسائل الإدارية',
                color: const Color(0xFFF59E0B),
                icon: Icons.notifications_active_rounded,
                btnText: 'قراءة الإشعارات',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsPage())),
              ),
              _buildSchoolCard(
                title: 'نتائجي',
                subtitle: 'عرض درجات الاختبارات والتقدم الأكاديمي',
                color: const Color(0xFFEC4899),
                icon: Icons.bar_chart_rounded,
                btnText: 'عرض النتائج',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ResultsPage())),
              ),
              _buildSchoolCard(
                title: 'إنجازاتي',
                subtitle: 'متابعة التقدم والحصول على الشارات',
                color: const Color(0xFF8B5CF6),
                icon: Icons.emoji_events_rounded,
                btnText: 'عرض الإنجازات',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AchievementsPage())),
              ),
              _buildSchoolCard(
                title: 'الملف الشخصي',
                subtitle: 'إدارة المعلومات والملف الأكاديمي',
                color: const Color(0xFF6366F1),
                icon: Icons.person_pin_rounded,
                btnText: 'تعديل الملف',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage())),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolCard({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
    required String btnText,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(backgroundColor: color.withOpacity(0.12), radius: 20, child: Icon(icon, color: color, size: 22)),
              Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            ],
          ),
          Text(subtitle, textAlign: TextAlign.right, style: const TextStyle(fontSize: 11, color: Colors.grey, height: 1.3)),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: color.withOpacity(0.15),
                foregroundColor: color,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(btnText, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

// --- 2. صفحة جدول الحصص ---
class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('جدول الحصص الدراسية'), backgroundColor: const Color(0xFF1E40AF), foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(leading: Icon(Icons.book, color: Colors.blue), title: Text('الرياضيات - 8:00 ص'), subtitle: Text('القاعة 12 | الأستاذ أحمد')),
          Divider(),
          ListTile(leading: Icon(Icons.language, color: Colors.green), title: Text('اللغة العربية - 9:00 ص'), subtitle: Text('القاعة 5 | الأستاذ محمد')),
          Divider(),
          ListTile(leading: Icon(Icons.science, color: Colors.orange), title: Text('العلوم - 10:30 ص'), subtitle: Text('المختبر | الأستاذ علي')),
        ],
      ),
    );
  }
}

// --- 3. صفحة الواجبات ---
class HomeworkPage extends StatelessWidget {
  const HomeworkPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الواجبات المدرسية'), backgroundColor: const Color(0xFF1E40AF), foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(title: Text('تمارين الرياضيات - الصفحة 45'), subtitle: Text('تاريخ التسليم: الغد'), trailing: Icon(Icons.check_circle_outline, color: Colors.orange))),
          Card(child: ListTile(title: Text('قراءة سورة الكهف'), subtitle: Text('تاريخ التسليم: الخميس'), trailing: Icon(Icons.check_circle, color: Colors.green))),
        ],
      ),
    );
  }
}

// --- 4. صفحة النتائج ---
class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نتائج الاختبارات'), backgroundColor: const Color(0xFF1E40AF), foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(title: Text('اختبار الرياضيات الشهر الأول'), trailing: Text('95/100', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green))),
          Divider(),
          ListTile(title: Text('اختبار اللغة الإنجليزية'), trailing: Text('88/100', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue))),
        ],
      ),
    );
  }
}

// --- 5. صفحة الإشعارات ---
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإشعارات المدرسية'), backgroundColor: const Color(0xFF1E40AF), foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(leading: Icon(Icons.campaign, color: Colors.amber), title: Text('إجازة رسمية يوم الأحد القادم'), subtitle: Text('بمناسبة العطلة الوطنية'))),
        ],
      ),
    );
  }
}

// --- 6. صفحة الإنجازات ---
class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إنجازاتي وشارات التفوق'), backgroundColor: const Color(0xFF1E40AF), foregroundColor: Colors.white),
      body: const Center(child: Text('🏆 الطالب المثالي للشهر الحالي!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
    );
  }
}

// --- 7. صفحة الملف الشخصي ---
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي للطالب'), backgroundColor: const Color(0xFF1E40AF), foregroundColor: Colors.white),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 40, child: Icon(Icons.person, size: 50)),
            SizedBox(height: 10),
            Text('طالب مدرسة كوثر الأهلية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('الصف الخامس الابتدائي', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// --- 8. صفحة الإعدادات ---
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات'), backgroundColor: const Color(0xFF1E40AF), foregroundColor: Colors.white),
      body: ListView(
        children: [
      ListTile(
        leading: const Icon(Icons.star),
        title: const Text('الطلاب المتفوقون'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  HonorStudentsScreen()),
          );
        },
      ),
      ListTile(leading: Icon(Icons.notifications), title: Text('تفعيل الإشعارات')),
      ListTile(leading: Icon(Icons.dark_mode), title: Text('الوضع الداكن')),
      ListTile(leading: Icon(Icons.lock), title: Text('تغيير كلمة المرور')),
    ],
      ),
    );
  }
}
