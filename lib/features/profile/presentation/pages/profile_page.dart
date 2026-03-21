import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/user_profile.dart';
import '../../providers/profile_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final menus = <Map<String, dynamic>>[
      {'title': 'Data Pribadi', 'route': '/personal-info'},
      {'title': 'Keluarga', 'route': '/family-members'},
      {'title': 'Resep Saya', 'route': '/prescriptions'},
      {'title': 'Pesanan Obat Saya', 'route': '/pharmacy-orders'},
      {'title': 'Alamat Saya', 'route': '/addresses'},
      {'title': 'Metode Pembayaran', 'route': '/payment-methods'},
      {'title': 'Notifikasi', 'route': '/notifications'},
      {'title': 'Bantuan', 'route': '/help'},
      {'title': 'Keluar', 'route': '/login', 'replace': true},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Profil'), centerTitle: false),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundColor: _backgroundColorForVariant(
                    profile.photoVariant,
                  ),
                  child: Icon(
                    _iconForVariant(profile.photoVariant),
                    size: 34,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  profile.fullName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.email,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...menus.map(
            (menu) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  final route = menu['route'];
                  if (route != null) {
                    final shouldReplace = menu['replace'] == true;
                    if (shouldReplace) {
                      context.go(route);
                    } else {
                      context.push(route);
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          menu['title']!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF9CA3AF),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Color _backgroundColorForVariant(String variant) {
    if (variant == UserProfile.photoVariantGreen) {
      return const Color(0xFF20B486);
    }
    if (variant == UserProfile.photoVariantOrange) {
      return const Color(0xFFEA580C);
    }
    return const Color(0xFF2F80ED);
  }

  static IconData _iconForVariant(String variant) {
    if (variant == UserProfile.photoVariantGreen) {
      return Icons.face_rounded;
    }
    if (variant == UserProfile.photoVariantOrange) {
      return Icons.sentiment_very_satisfied_rounded;
    }
    return Icons.person_rounded;
  }
}
