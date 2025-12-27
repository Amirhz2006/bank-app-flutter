import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  static const routeName = '/signup';
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  void _signupMock() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('ثبت ‌نام مثلا انجام شد.')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('ثبت نام')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              children: [
                TextField(
                  controller: _name,
                  decoration: const InputDecoration(
                    labelText: 'نام و نام خانوادگی',
                    prefixIcon: Icon(Icons.badge),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _username,
                  decoration: const InputDecoration(
                    labelText: 'نام کاربری',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'رمز عبور',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _signupMock,
                  child: const Text('ثبت نام (نمایشی)'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
