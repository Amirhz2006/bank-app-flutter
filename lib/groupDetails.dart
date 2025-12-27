import 'package:flutter/material.dart';

class groupDetails extends StatelessWidget {
  static const routeName = '/group';
  const groupDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final group = (ModalRoute.of(context)?.settings.arguments as Map?) ?? {};
    final members = [
      {"name": "سعید"},
      {"name": "علی"},
      {"name": "مریم"},
    ];

    final expenses1 = [
      {
        "title": "مواد غذایی",
        "paidBy": "سعید",
        "amount": 900000,
        "date": "1404/07/10",
      },
      {
        "title": "قبض اینترنت",
        "paidBy": "علی",
        "amount": 450000,
        "date": "1404/07/11",
      },
      {
        "title": "شارژ ساختمان",
        "paidBy": "مریم",
        "amount": 1200000,
        "date": "1404/07/12",
      },
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('گروه: ${group["name"] ?? "-"}')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'نام گروه: ${group["name"] ?? "-"}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('تعداد اعضا: ${members.length}'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: members
                          .map((m) => Chip(label: Text(m["name"] as String)))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            const Text(
              'هزینه‌ها',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            ...expenses1.map(
              (e) => Card(
                child: ListTile(
                  leading: const Icon(Icons.receipt_long),
                  title: Text(e["title"] as String),
                  subtitle: Text('${e["date"]} • پرداخت‌کننده: ${e["paidBy"]}'),
                  trailing: Text('${_money(e["amount"] as int)} تومان'),
                ),
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              'عملیات',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),

            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('افزودن هزینه جدید (نمایشی)'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.calculate),
              label: const Text('مشاهده نتیجه نهایی (نمایشی)'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.payments),
              label: const Text('تسویه حساب (نمایشی)'),
            ),
          ],
        ),
      ),
    );
  }

  String _money(int amount) {
    final s = amount.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final x = s.length - i;
      buf.write(s[i]);
      if (x > 1 && x % 3 == 1) buf.write(',');
    }
    return buf.toString();
  }
}
