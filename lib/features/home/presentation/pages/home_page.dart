import 'package:flutter/material.dart';
import '../widgets/checkin_card.dart';
import '../widgets/feature_grid.dart';
import '../widgets/home_bottom_nav.dart';
import '../widgets/home_header.dart';
import '../widgets/promo_banner.dart';
import '../widgets/reminder_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const HomeBottomNav(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            const HomeHeader(),
            const SizedBox(height: 20),
            const CheckInCard(),
            const SizedBox(height: 24),
            const FeatureGrid(),
            const SizedBox(height: 24),
            const ReminderSection(),
            const SizedBox(height: 24),
            const PromoBanner(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
