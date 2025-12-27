import 'package:flutter/material.dart';

class accountDetails extends StatelessWidget {
  static const routeName = '/account';

  const accountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final account = (ModalRoute.of(context)?.settings.arguments as Map?) ?? {};

    final transactions = [
      {
        "title": "واریز حقوق",
        "type": "واریز",
        "amount": 8000000,
        "date": "1404/07/10",
        "category": "حقوق",
      },
      {
        "title": "پرداخت اجاره",
        "type": "برداشت",
        "amount": 3000000,
        "date": "1404/07/12",
        "category": "اجاره",
      },
      {
        "title": "خرید فروشگاه",
        "type": "برداشت",
        "amount": 450000,
        "date": "1404/07/14",
        "category": "مخارج زندگی",
      },
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('جزئیات حساب')),
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
                      'نوع حساب: ${account["type"] ?? "-"}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('شماره حساب: ${account["accountNumber"] ?? "-"}'),
                    Text('شماره کارت: ${account["cardNumber"] ?? "-"}'),
                    const SizedBox(height: 8),
                    Text(
                      'موجودی: ${_money((account["balance"] ?? 0) as int)} تومان',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'عملیات',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _ActionChipBtn(
                  label: 'انتقال وجه (نمایشی)',
                  icon: Icons.swap_horiz,
                  onTap: () {},
                ),
                _ActionChipBtn(
                  label: 'تغییر رمز کارت (نمایشی)',
                  icon: Icons.password,
                  onTap: () {},
                ),
                _ActionChipBtn(
                  label: 'دانلود صورت حساب (نمایشی)',
                  icon: Icons.download,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'تاریخچه تراکنش‌ها',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            ...transactions.map((t) {
              final isDeposit = t["type"] == "واریز";
              final amount = t["amount"] as int;

              return Card(
                child: ListTile(
                  leading: Icon(
                    isDeposit ? Icons.arrow_downward : Icons.arrow_upward,
                  ),
                  title: Text('${t["title"]}'),
                  subtitle: Text('${t["date"]} • دسته: ${t["category"]}'),
                  trailing: Text(
                    '${isDeposit ? "+" : "-"}${_money(amount)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: isDeposit ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              );
            }),
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
      if (x > 1 && x % 3 == 1) {
        buf.write(',');
      }
    }

    return buf.toString();
  }
}

class _ActionChipBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionChipBtn({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Chip(
        avatar: Icon(icon, size: 18),
        label: Text(label),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
    );
  }
}
