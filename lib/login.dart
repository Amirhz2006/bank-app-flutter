import 'package:flutter/material.dart';
import 'home.dart';
import 'signup.dart';

class login extends StatefulWidget {
  static const routeName = '/login';

  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  void _loginMock() {
    Navigator.pushReplacementNamed(context, home.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('ورود')),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.account_balance, size: 72),
                  const SizedBox(height: 12),
                  const Text(
                    'سامانه خدمات بانکی و مدیریت هزینه‌های مشترک',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 20),
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
                    onPressed: _loginMock,
                    child: const Text('ورود (نمایشی)'),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, signup.routeName),
                    child: const Text('ثبت نام'),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
