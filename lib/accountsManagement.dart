import 'package:flutter/material.dart';
import 'accountDetails.dart';

class accountsManagement extends StatefulWidget {
  static const routeName = '/accounts';
  const accountsManagement({super.key});

  @override
  State<accountsManagement> createState() => _accountsManagementState();
}

class _accountsManagementState extends State<accountsManagement> {
  final List<Map<String, dynamic>> _allAccounts = [
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
      "balance": 4200000,
    },
    {
      "id": "A3",
      "type": "جاری",
      "accountNumber": "1122334455",
      "cardNumber": "6037-1122-3344-5566",
      "balance": 7500000,
    },
    {
      "id": "A4",
      "type": "پس‌انداز",
      "accountNumber": "5566778899",
      "cardNumber": "5892-5566-7788-9900",
      "balance": 15000000,
    },
    {
      "id": "A5",
      "type": "جاری",
      "accountNumber": "9876543210",
      "cardNumber": "6037-9876-5432-1010",
      "balance": 3200000,
    },
  ];

  List<Map<String, dynamic>> _filteredAccounts = [];
  final TextEditingController _searchController = TextEditingController();
  String? _selectedFilterType;
  final List<String> _filterTypes = ['همه', 'جاری', 'پس‌انداز'];

  @override
  void initState() {
    super.initState();
    _filteredAccounts = _allAccounts;
    _selectedFilterType = 'همه';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterAccounts() {
    setState(() {
      _filteredAccounts = _allAccounts.where((account) {
        bool matchesSearch = _searchController.text.isEmpty ||
            account["accountNumber"]
                .toString()
                .contains(_searchController.text) ||
            account["cardNumber"]
                .toString()
                .replaceAll('-', '')
                .contains(_searchController.text.replaceAll('-', ''));

        bool matchesType = _selectedFilterType == 'همه' ||
            account["type"] == _selectedFilterType;

        return matchesSearch && matchesType;
      }).toList();
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _filterAccounts();
  }

  void _resetFilters() {
    _searchController.clear();
    setState(() {
      _selectedFilterType = 'همه';
      _filteredAccounts = _allAccounts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('مدیریت حساب‌ها'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _resetFilters,
              tooltip: 'ریست فیلترها',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('حساب جدید (نمایشی)'),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (_) => _filterAccounts(),
                          decoration: InputDecoration(
                            hintText: 'جستجوی شماره حساب یا کارت...',
                            prefixIcon: const Icon(Icons.search, size: 20),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: _clearSearch,
                            )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.filter_list, size: 18, color: Colors.grey),
                      const SizedBox(width: 8),
                      const Text(
                        'فیلتر بر اساس:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedFilterType,
                          items: _filterTypes.map((String type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedFilterType = newValue;
                              _filterAccounts();
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_filteredAccounts.length} حساب یافت شد',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                      if (_searchController.text.isNotEmpty ||
                          _selectedFilterType != 'همه')
                        TextButton(
                          onPressed: _resetFilters,
                          child: const Text('حذف فیلترها'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: _filteredAccounts.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'حسابی یافت نشد',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _resetFilters,
                      child: const Text('مشاهده همه حساب‌ها'),
                    ),
                  ],
                ),
              )
                  : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: _filteredAccounts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final a = _filteredAccounts[i];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: a["type"] == 'جاری'
                              ? Colors.blue.withOpacity(0.1)
                              : Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          a["type"] == 'جاری'
                              ? Icons.account_balance_wallet
                              : Icons.savings,
                          color: a["type"] == 'جاری'
                              ? Colors.blue
                              : Colors.green,
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(
                            'حساب ${a["type"]}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              a["type"],
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.credit_card,
                                size: 14,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'شماره حساب: ${a["accountNumber"]}',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.card_membership,
                                size: 14,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'شماره کارت: ${a["cardNumber"]}',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${_money(a["balance"] as int)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: a["balance"] > 0
                                  ? Colors.green
                                  : Colors.black,
                            ),
                          ),
                          const Text(
                            'تومان',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
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
          ],
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