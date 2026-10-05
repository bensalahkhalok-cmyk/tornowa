import 'package:flutter/material.dart';

class PlayerDashboard extends StatelessWidget {
  const PlayerDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم اللاعب'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[400]!, Colors.blue[600]!],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person, size: 40),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'أحمد محمد',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'رقم 7 - وسط',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const Text(
                    'فريق النجوم',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'إحصائياتك',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatCard(label: 'مباريات', value: '5'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(label: 'أهداف', value: '3'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(label: 'تمريرات', value: '8'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'المباريات القادمة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _PlayerMatchCard(
              opponent: 'فريق الشمس',
              date: 'الجمعة الساعة 17:00',
              status: 'توقع الحضور',
              confirmed: true,
            ),
            const SizedBox(height: 12),
            _PlayerMatchCard(
              opponent: 'فريق النسور',
              date: 'الأحد الساعة 19:00',
              status: 'لم تؤكد الحضور',
              confirmed: false,
            ),
            const SizedBox(height: 24),
            const Text(
              'الأخبار والتنبيهات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...[
              'تم تحديث جدول المباريات',
              'كابتن الفريق طلب منك تأكيد الحضور',
              'فريقك حقق فوزًا 3-1',
              'تم إضافة لاعب جديد للفريق',
            ].map((notification) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber[50],
                    border: Border.all(color: Colors.amber[200]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.notifications, color: Colors.amber),
                      const SizedBox(width: 12),
                      Expanded(child: Text(notification)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(label, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }
}

class _PlayerMatchCard extends StatelessWidget {
  final String opponent;
  final String date;
  final String status;
  final bool confirmed;

  const _PlayerMatchCard({
    required this.opponent,
    required this.date,
    required this.status,
    required this.confirmed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: confirmed ? Colors.green[50] : Colors.red[50],
        border: Border.all(
          color: confirmed ? Colors.green[300]! : Colors.red[300]!,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'vs $opponent',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(date, style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                status,
                style: TextStyle(
                  color: confirmed ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              confirmed
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.cancel, color: Colors.red),
            ],
          ),
          if (!confirmed)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('تأكيد الحضور'),
              ),
            ),
        ],
      ),
    );
  }
}
