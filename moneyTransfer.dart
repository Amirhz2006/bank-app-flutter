import 'package:flutter/material.dart';

class moneyTransfer extends StatefulWidget {
  static const routeName = '/moneyTransfer';
  const moneyTransfer({super.key});

  @override
  State<moneyTransfer> createState() => _moneyTransferState();
}

class _moneyTransferState extends State<moneyTransfer> {
  final _sourceAccountController = TextEditingController();
  final _destAccountController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _transferMethod;
  String? _selectedAccountType;

  final List<Map<String, dynamic>> _transferMethods = [
    {"id": "card", "name": "Card to Card", "fee": 0, "limit": 10000000},
    {"id": "sheba", "name": "Sheba (Account to Account)", "fee": 500, "limit": 50000000},
    {"id": "internal", "name": "Internal Bank", "fee": 0, "limit": null},
    {"id": "instant", "name": "Instant", "fee": 1000, "limit": 2000000},
  ];

  void _transferMock() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Money transfer successful (demo)')),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _sourceAccountController.dispose();
    _destAccountController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('انتقال وجه')),
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
                      DropdownButtonFormField<String>(
                        value: _selectedAccountType,
                        decoration: const InputDecoration(
                          labelText: 'حساب مبدا',
                          prefixIcon: Icon(Icons.account_balance_wallet),
                        ),
                        items: const [
                          DropdownMenuItem<String>(
                            value: null,
                            child: Text('Select account'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'current',
                            child: Text('Current Account - 1234567890'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'saving',
                            child: Text('Saving Account - 9988776655'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedAccountType = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _destAccountController,
                        decoration: const InputDecoration(
                          labelText: 'شماره حساب/کارت/شبا مقصد',
                          hintText: 'Example: IR123456789012345678901234',
                          prefixIcon: Icon(Icons.account_balance),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _amountController,
                        decoration: const InputDecoration(
                          labelText: 'مبلغ (تومان)',
                          hintText: 'Example: 1000000',
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _transferMethod,
                        decoration: const InputDecoration(
                          labelText: 'روش انتقال',
                          prefixIcon: Icon(Icons.compare_arrows),
                        ),
                        items: _transferMethods.map((method) {
                          final fee = method["fee"] as int;
                          final limit = method["limit"];
                          final limitText = limit == null
                              ? 'No limit'
                              : 'Limit: ${_money(limit)} Toman';
                          return DropdownMenuItem<String>(
                            value: method["id"] as String,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(method["name"] as String),
                                Text(
                                  'Fee: ${_money(fee)} Toman • $limitText',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _transferMethod = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'شرح تراکنش (اختیاری)',
                          hintText: 'Example: Debt payment',
                          prefixIcon: Icon(Icons.description),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _transferMock,
                          icon: const Icon(Icons.send_and_archive),
                          label: const Text('انجام انتقال (نمایشی)'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'کارمزد و سقف انتقال',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Transfer amount:'),
                          Text('5,000,000 Toman', style: TextStyle(fontWeight: FontWeight.w700)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Fee:'),
                          Text('500 Toman', style: TextStyle(color: Colors.green)),
                        ],
                      ),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total payable:'),
                          Text(
                            '5,000,500 Toman',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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