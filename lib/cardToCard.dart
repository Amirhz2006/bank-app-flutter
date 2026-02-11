// file name: cardToCard.dart
import 'package:flutter/material.dart';

class cardToCard extends StatefulWidget {
  static const routeName = '/cardToCard';
  const cardToCard({super.key});

  @override
  State<cardToCard> createState() => _cardToCardState();
}

class _cardToCardState extends State<cardToCard> {
  final _sourceCardController = TextEditingController();
  final _destCardController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedBank;

  final List<Map<String, dynamic>> _recentTransfers = [
    {"card": "6037-****-****-4455", "amount": 500000, "date": "1404/07/15"},
    {"card": "6104-****-****-7788", "amount": 1200000, "date": "1404/07/14"},
    {"card": "5892-****-****-1122", "amount": 750000, "date": "1404/07/13"},
  ];

  void _transferMock() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('انتقال کارت به کارت با موفقیت انجام شد (نمایشی)')),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _sourceCardController.dispose();
    _destCardController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('کارت به کارت')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _sourceCardController,
                        decoration: const InputDecoration(
                          labelText: 'شماره کارت مبدا',
                          hintText: 'مثال: 6037-9911-2233-4455',
                          prefixIcon: Icon(Icons.credit_card),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _destCardController,
                        decoration: const InputDecoration(
                          labelText: 'شماره کارت مقصد',
                          hintText: 'مثال: 6104-7788-9900-1122',
                          prefixIcon: Icon(Icons.credit_card),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField(
                        value: _selectedBank,
                        decoration: const InputDecoration(
                          labelText: 'بانک مقصد (اختیاری)',
                          prefixIcon: Icon(Icons.account_balance),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: null,
                            child: Text('انتخاب نشده'),
                          ),
                          DropdownMenuItem(
                            value: 'melli',
                            child: Text('ملی'),
                          ),
                          DropdownMenuItem(
                            value: 'saderat',
                            child: Text('صادرات'),
                          ),
                          DropdownMenuItem(
                            value: 'mellat',
                            child: Text('ملت'),
                          ),
                          DropdownMenuItem(
                            value: 'tejarat',
                            child: Text('تجارت'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedBank = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _amountController,
                        decoration: const InputDecoration(
                          labelText: 'مبلغ (تومان)',
                          hintText: 'مثال: 1000000',
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _transferMock,
                          icon: const Icon(Icons.send),
                          label: const Text('انتقال وجه (نمایشی)'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'تاریخچه انتقال‌های اخیر',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              ..._recentTransfers.map((transfer) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.credit_card_outlined),
                    title: Text('به کارت: ${transfer["card"]}'),
                    subtitle: Text('تاریخ: ${transfer["date"]}'),
                    trailing: Text(
                      '${_money(transfer["amount"] as int)} تومان',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                );
              }),
            ],
          ),
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