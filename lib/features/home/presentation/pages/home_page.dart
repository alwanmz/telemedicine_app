import 'package:flutter/material.dart';
import '../widgets/checkin_card.dart';
import '../widgets/feature_grid.dart';
import '../widgets/home_header.dart';
import '../widgets/promo_banner.dart';
import '../widgets/reminder_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: const [
          HomeHeader(),
          SizedBox(height: 20),
          CheckInCard(),
          SizedBox(height: 24),
          FeatureGrid(),
          SizedBox(height: 24),
          ReminderSection(),
          SizedBox(height: 24),
          PromoBanner(),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
