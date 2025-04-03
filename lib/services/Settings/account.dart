import 'package:flutter/material.dart';

class UserAccounts extends StatefulWidget {
  const UserAccounts({super.key});

  @override
  State<UserAccounts> createState() => _UserAccountsState();
}

class _UserAccountsState extends State<UserAccounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Accounts",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(child: Text("Hello, Welcome User!")),
    );
  }
}
