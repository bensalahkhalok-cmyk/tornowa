import 'package:flutter/material.dart';

class CaptainDashboard extends StatelessWidget {
  const CaptainDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم كابتن الفريق'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'فريقك',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text(
                    'فريق النجوم',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('عدد اللاعبين: 12'),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('دعوة لاعب'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'قائمة اللاعبين',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...[
              'أحمد محمد',
              'علي ناصر',
              'محمود إبراهيم',
              'خالد سالم',
            ].map((name) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(name),
                  subtitle: const Text('لاعب - وسط'),
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                ),
              );
            }).toList(),
            const SizedBox(height: 24),
            const Text(
              'المباريات القادمة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _UpcomingMatchCard(
              opponent: 'فريق الشمس',
              date: 'الجمعة - 17:00',
              venue: 'ملعب النيل',
            ),
            const SizedBox(height: 12),
            _UpcomingMatchCard(
              opponent: 'فريق النسور',
              date: 'الأحد - 19:00',
              venue: 'ملعب الجامعة',
            ),
          ],
        ),
      ),
    );
  }
}

class _UpcomingMatchCard extends StatelessWidget {
  final String opponent;
  final String date;
  final String venue;

  const _UpcomingMatchCard({
    required this.opponent,
    required this.date,
    required this.venue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(color: Colors.blue),
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
          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(date),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(venue),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            child: const Text('تحديد التشكيلة'),
          ),
        ],
      ),
    );
  }
}
