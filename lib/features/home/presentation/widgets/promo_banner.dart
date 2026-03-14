import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF16B3AC), Color(0xFF0F9B8E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cek resiko diabetes anda',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ada beberapa evaluasi sederhana yang bisa kamu isi dari rumah.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withOpacity(0.92),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.secondary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Cek di sini'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.favorite_outline_rounded,
              color: Colors.white,
              size: 38,
            ),
          ),
        ],
      ),
    );
  }
}
