import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const notifications = [
      _NotificationItem(
        title: 'Janji temu Anda dikonfirmasi',
        description:
            'Dr. Amanda Putri akan menerima konsultasi Anda pada 24 Maret 2026 pukul 09.00.',
        category: 'appointment',
        timeLabel: '10 menit lalu',
      ),
      _NotificationItem(
        title: 'Resep baru telah tersedia',
        description:
            'Resep dari Dr. Budi Santoso sudah bisa Anda lihat dan tebus dari halaman Resep Saya.',
        category: 'prescription',
        timeLabel: '1 jam lalu',
      ),
      _NotificationItem(
        title: 'Pesanan obat sedang dikirim',
        description:
            'Pesanan ORD-24031502 sedang dalam perjalanan ke alamat utama Anda.',
        category: 'pharmacy_order',
        timeLabel: '3 jam lalu',
      ),
      _NotificationItem(
        title: 'Pengingat konsultasi besok',
        description:
            'Jangan lupa konsultasi lanjutan Anda besok pagi. Pastikan koneksi internet stabil.',
        category: 'appointment',
        timeLabel: 'Kemarin',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Notifikasi'), centerTitle: false),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        itemCount: notifications.length,
        separatorBuilder: (_, _) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final item = notifications[index];

          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _backgroundColorForCategory(item.category),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    _iconForCategory(item.category),
                    color: _iconColorForCategory(item.category),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item.timeLabel,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          _labelForCategory(item.category),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4B5563),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Color _backgroundColorForCategory(String category) {
    if (category == 'prescription') {
      return const Color(0xFFE9FBF6);
    }
    if (category == 'pharmacy_order') {
      return const Color(0xFFFFF7ED);
    }
    return const Color(0xFFEAF4FF);
  }

  static Color _iconColorForCategory(String category) {
    if (category == 'prescription') {
      return const Color(0xFF20B486);
    }
    if (category == 'pharmacy_order') {
      return const Color(0xFFEA580C);
    }
    return const Color(0xFF2F80ED);
  }

  static IconData _iconForCategory(String category) {
    if (category == 'prescription') {
      return Icons.receipt_long_rounded;
    }
    if (category == 'pharmacy_order') {
      return Icons.local_shipping_rounded;
    }
    return Icons.calendar_month_rounded;
  }

  static String _labelForCategory(String category) {
    if (category == 'prescription') {
      return 'Resep';
    }
    if (category == 'pharmacy_order') {
      return 'Pesanan Obat';
    }
    return 'Janji Temu';
  }
}

class _NotificationItem {
  final String title;
  final String description;
  final String category;
  final String timeLabel;

  const _NotificationItem({
    required this.title,
    required this.description,
    required this.category,
    required this.timeLabel,
  });
}
