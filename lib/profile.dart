import 'package:flutter/material.dart';
import 'editProfile.dart';

class profile extends StatelessWidget {
  static const routeName = '/profile';

  const profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('پروفایل کاربری'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.badge),
                      title: Text('نام و نام خانوادگی'),
                      subtitle: Text('سعید محمدی'),
                    ),
                    Divider(height: 2),
                    ListTile(
                      leading: Icon(Icons.alternate_email),
                      title: Text('نام کاربری'),
                      subtitle: Text('saeed@dev.com'),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, editProfile.routeName),
                  icon: const Icon(Icons.edit),
                  label: const Text('ویرایش پروفایل'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/login'),
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    'خروج از حساب',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
