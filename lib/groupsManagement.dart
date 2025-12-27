import 'package:flutter/material.dart';
import 'GroupDetails.dart';

class groupsManagement extends StatelessWidget {
  static const routeName = '/groups';
  const groupsManagement({super.key});
  @override
  Widget build(BuildContext context) {
    final groups = [
      {"id": "G1", "name": "خانه", "membersCount": 3, "totalExpenses": 2550000},
      {
        "id": "G2",
        "name": "سفر شمال",
        "membersCount": 3,
        "totalExpenses": 2900000,
      },
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('گروه‌های مشترک')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('گروه جدید (نمایشی)'),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: groups.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            final g = groups[i];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.groups),
                title: Text(g["name"] as String),
                subtitle: Text(
                  'اعضا: ${g["membersCount"]} • جمع هزینه‌ها: ${_money(g["totalExpenses"] as int)}',
                ),
                onTap: () => Navigator.pushNamed(
                  context,
                  groupDetails.routeName,
                  arguments: g,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _money(int amount) {
    final s = amount.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final idxFromEnd = s.length - i;
      buf.write(s[i]);
      if (idxFromEnd > 1 && idxFromEnd % 3 == 1) buf.write(',');
    }
    return buf.toString();
  }
}
