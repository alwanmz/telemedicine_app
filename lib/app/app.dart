import 'package:flutter/material.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class TelemedicineApp extends StatelessWidget {
  const TelemedicineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Telemedicine App',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
