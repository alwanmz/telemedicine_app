import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    const faqItems = [
      _FaqItem(
        question: 'Bagaimana cara menjadwalkan ulang janji temu?',
        answer:
            'Buka detail janji temu Anda, lalu gunakan tombol jadwal ulang yang tersedia selama status janji temu masih aktif.',
      ),
      _FaqItem(
        question: 'Di mana saya bisa melihat resep dokter?',
        answer:
            'Masuk ke menu Profil, pilih Resep Saya, lalu buka detail resep untuk melihat daftar obat dan catatan dokter.',
      ),
      _FaqItem(
        question: 'Bagaimana cara melacak pesanan obat?',
        answer:
            'Masuk ke Pesanan Obat Saya untuk melihat status pembayaran, status pemenuhan, dan detail pengiriman.',
      ),
    ];

    const contactItems = [
      _ContactItem(
        title: 'Pusat Bantuan',
        subtitle: 'help@telemedicine.app',
        icon: Icons.support_agent_rounded,
      ),
      _ContactItem(
        title: 'Hotline',
        subtitle: '1500-321',
        icon: Icons.call_rounded,
      ),
      _ContactItem(
        title: 'Jam Operasional',
        subtitle: 'Setiap hari, 08.00 - 21.00 WIB',
        icon: Icons.access_time_filled_rounded,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Bantuan'), centerTitle: false),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Butuh bantuan?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Temukan jawaban cepat untuk pertanyaan umum atau hubungi tim bantuan kami jika Anda membutuhkan pendampingan lebih lanjut.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'FAQ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 14),
                ...faqItems.map((item) {
                  final isLast = item == faqItems.last;

                  return Padding(
                    padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.question,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.answer,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF6B7280),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hubungi Kami',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 14),
                ...contactItems.map((item) {
                  final isLast = item == contactItems.last;

                  return Padding(
                    padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
                    child: Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF4FF),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            item.icon,
                            color: const Color(0xFF2F80ED),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.subtitle,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqItem {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});
}

class _ContactItem {
  final String title;
  final String subtitle;
  final IconData icon;

  const _ContactItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
