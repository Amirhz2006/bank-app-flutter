import 'package:flutter/material.dart';
import 'profile.dart';
import 'login.dart';
import 'signup.dart';
import 'home.dart';
import 'accountsManagement.dart';
import 'accountDetails.dart';
import 'groupsManagement.dart';
import 'groupDetails.dart';

void main() {
  runApp(const BankPhase1App());
}

class BankPhase1App extends StatelessWidget {
  const BankPhase1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        fontFamily: 'Vazir',
      ),
      initialRoute: login.routeName,
      routes: {
        login.routeName: (_) => const login(),
        signup.routeName: (_) => const signup(),
        home.routeName: (_) => const home(),
        accountsManagement.routeName: (_) => const accountsManagement(),
        accountDetails.routeName: (_) => const accountDetails(),
        groupsManagement.routeName: (_) => const groupsManagement(),
        groupDetails.routeName: (_) => const groupDetails(),
        profile.routeName: (_) => const profile(),
      },
    );
  }
}
