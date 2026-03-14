import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../widgets/feature_item.dart';
import '../widgets/reminder_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildConsultationCard(),
                    const SizedBox(height: 24),
                    _buildFeatureGrid(),
                    const SizedBox(height: 24),
                    Text('Pengingat', style: AppTextStyles.headlineMedium),
                    const SizedBox(height: 12),
                    const ReminderCard(
                      title: 'Konsultasi Besok',
                      subtitle: 'Dr. Amanda Putri - 09:30 WIB',
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Layanan Kesehatan',
                      style: AppTextStyles.headlineMedium,
                    ),
                    const SizedBox(height: 12),
                    _buildHealthServiceBanner(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.person, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Halo, Alwan 👋', style: AppTextStyles.titleMedium),
              const SizedBox(height: 4),
              Text('Jaga kesehatanmu hari ini', style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded),
        ),
      ],
    );
  }

  Widget _buildConsultationCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2F80ED), Color(0xFF56CCF2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Butuh Konsultasi Cepat?',
            style: AppTextStyles.headlineMedium.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Hubungi dokter umum atau spesialis langsung dari aplikasi.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.92),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            ),
            child: const Text('Mulai Konsultasi'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FeatureItem(icon: Icons.medical_services_outlined, label: 'Dokter'),
          FeatureItem(icon: Icons.calendar_month_outlined, label: 'Janji Temu'),
          FeatureItem(icon: Icons.receipt_long_outlined, label: 'Resep'),
          FeatureItem(icon: Icons.local_hospital_outlined, label: 'Riwayat'),
        ],
      ),
    );
  }

  Widget _buildHealthServiceBanner() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Paket Medical Checkup', style: AppTextStyles.titleMedium),
                const SizedBox(height: 6),
                Text(
                  'Cek kesehatan rutin dengan promo khusus bulan ini.',
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Lihat Detail'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.reminderBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.favorite_outline,
              size: 36,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article_outlined),
          label: 'Riwayat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profil',
        ),
      ],
    );
  }
}
