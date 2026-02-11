import 'package:flutter/material.dart';
import 'cardToCard.dart';
import 'moneyTransfer.dart';
import 'editProfile.dart';
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
      title: 'سامانه بانکی',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
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
        cardToCard.routeName: (_) => const cardToCard(),
        moneyTransfer.routeName: (_) => const moneyTransfer(),
        editProfile.routeName: (_) => const editProfile(),
      },
    );
  }
}