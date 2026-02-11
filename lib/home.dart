import 'package:flutter/material.dart';
import 'accountsManagement.dart';
import 'groupsManagement.dart';
import 'login.dart';
import 'profile.dart';
import 'cardToCard.dart';
import 'moneyTransfer.dart';

class home extends StatelessWidget {
  static const routeName = '/home';

  const home({super.key});

  @override
  Widget build(BuildContext context) {
    const userName = 'سعید';

    final accounts = [
      {"type": "جاری", "balance": 12500000},
      {"type": "پس‌انداز", "balance": 42000000},
    ];

    int totalBalance = 0;
    for (int i = 0; i < accounts.length; i++) {
      totalBalance += accounts[i]["balance"] as int;
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text('داشبورد'),
          actions: [
            IconButton(
              tooltip: 'خروج',
              icon: const Icon(Icons.logout),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                login.routeName,
                (_) => false,
              ),
            ),
          ],
        ),
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
                      'سلام، $userName 👋',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'موجودی کل: ${_money(totalBalance)} تومان',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'دسترسی سریع',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _QuickCard(
                  title: 'پروفایل من',
                  icon: Icons.person_outline,
                  onTap: () => Navigator.pushNamed(context, profile.routeName),
                ),
                _QuickCard(
                  title: 'مدیریت حساب‌ها',
                  icon: Icons.account_balance_wallet,
                  onTap: () => Navigator.pushNamed(
                    context,
                    accountsManagement.routeName,
                  ),
                ),
                _QuickCard(
                  title: 'گروه‌های مشترک',
                  icon: Icons.groups,
                  onTap: () =>
                      Navigator.pushNamed(context, groupsManagement.routeName),
                ),
                _QuickCard(
                  title: 'کارت به کارت',
                  icon: Icons.credit_card,
                  onTap: () => Navigator.pushNamed(context, cardToCard.routeName),
                ),
                _QuickCard(
                  title: 'انتقال پول',
                  icon: Icons.swap_horiz,
                    onTap: () => Navigator.pushNamed(context, moneyTransfer.routeName),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static String _money(int amount) {
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

class _QuickCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 28),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
