import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;

  const AuthScaffold({super.key, required this.child, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      appBar: appBar,
      body: SafeArea(child: child),
    );
  }
}
