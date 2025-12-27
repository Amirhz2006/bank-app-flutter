import 'package:flutter/material.dart';
import 'accountDetails.dart';

class accountsManagement extends StatelessWidget {
  static const routeName = '/accounts';
  const accountsManagement({super.key});

  @override
  Widget build(BuildContext context) {
    final accounts = [
      {
        "id": "A1",
        "type": "جاری",
        "accountNumber": "1234567890",
        "cardNumber": "6037-9911-2233-4455",
        "balance": 12500000,
      },
      {
        "id": "A2",
        "type": "پس‌انداز",
        "accountNumber": "9988776655",
        "cardNumber": "5892-1100-3344-5566",
        "balance": 42000000,
      },
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('مدیریت حساب‌ها')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('حساب جدید (نمایشی)'),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: accounts.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            final a = accounts[i];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.account_balance),
                title: Text('حساب ${a["type"]}'),
                subtitle: Text('شماره حساب: ${a["accountNumber"]}'),
                trailing: Text('${_money(a["balance"] as int)} تومان'),
                onTap: () => Navigator.pushNamed(
                  context,
                  accountDetails.routeName,
                  arguments: a,
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
