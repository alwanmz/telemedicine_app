import 'package:flutter/material.dart';
import '../../../../app/theme/app_text_styles.dart';
import 'feature_item.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const FeatureItem(
        icon: Icons.description_outlined,
        label: 'Resume\nMedis',
        iconBg: Color(0xFFEAF4FF),
        iconColor: Color(0xFF2F80ED),
        showBadge: true,
      ),
      const FeatureItem(
        icon: Icons.menu_book_outlined,
        label: 'Diari\nKesehatan',
        iconBg: Color(0xFFE9FBF6),
        iconColor: Color(0xFF20B486),
        showBadge: true,
      ),
      const FeatureItem(
        icon: Icons.favorite_border_rounded,
        label: 'Kesehatan\nIbu & Anak',
        iconBg: Color(0xFFFFEEF3),
        iconColor: Color(0xFFFF5A7A),
        showBadge: true,
      ),
      const FeatureItem(
        icon: Icons.notifications_active_outlined,
        label: 'Pengingat\nMinum Obat',
        iconBg: Color(0xFFEFF8FF),
        iconColor: Color(0xFF3A86FF),
      ),
      const FeatureItem(
        icon: Icons.vaccines_outlined,
        label: 'Vaksin\nCovid-19',
        iconBg: Color(0xFFFFF6E8),
        iconColor: Color(0xFFF5A623),
      ),
      const FeatureItem(
        icon: Icons.local_hospital_outlined,
        label: 'Buat Janji\nRumah Sakit',
        iconBg: Color(0xFFEAF4FF),
        iconColor: Color(0xFF2F80ED),
      ),
      const FeatureItem(
        icon: Icons.chat_bubble_outline_rounded,
        label: 'Teledokter',
        iconBg: Color(0xFFE9FBF6),
        iconColor: Color(0xFF20B486),
      ),
      const FeatureItem(
        icon: Icons.grid_view_rounded,
        label: 'Lainnya',
        iconBg: Color(0xFFF3F4F6),
        iconColor: Color(0xFF6B7280),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Fitur', style: AppTextStyles.titleMedium),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 18,
            crossAxisSpacing: 12,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) => items[index],
        ),
      ],
    );
  }
}
