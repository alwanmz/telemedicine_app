import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessions = _buildDummySessions();

    return Scaffold(
      appBar: AppBar(title: const Text('Chat Konsultasi'), centerTitle: false),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        itemCount: sessions.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final session = sessions[index];
          final status = session['status'] as String? ?? 'Belum Dimulai';

          return InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              context.push('/chat-room', extra: session);
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE5E7EB)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF4FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.medical_services_rounded,
                      color: Color(0xFF2F80ED),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                session['doctorName'] as String? ?? '-',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              session['time'] as String? ?? '-',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF9CA3AF),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          session['specialization'] as String? ?? '-',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2F80ED),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          session['lastMessage'] as String? ?? '-',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.5,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _SessionStatusBadge(status: status),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<Map<String, dynamic>> _buildDummySessions() {
    return [
      {
        'id': 'chat_1',
        'doctorName': 'Dr. Amanda Putri, Sp.PD',
        'specialization': 'Penyakit Dalam',
        'time': '09:12',
        'status': 'Aktif',
        'lastMessage': 'Silakan lanjutkan obat selama 3 hari dan minum air putih yang cukup.',
        'messages': [
          {
            'sender': 'doctor',
            'text': 'Selamat pagi, bagaimana kondisi tekanan darah hari ini?',
            'time': '08:55',
          },
          {
            'sender': 'patient',
            'text': 'Masih agak pusing, Dok. Tekanan darah tadi 145/90.',
            'time': '08:58',
          },
          {
            'sender': 'doctor',
            'text': 'Baik, silakan lanjutkan obat selama 3 hari dan minum air putih yang cukup.',
            'time': '09:12',
          },
        ],
      },
      {
        'id': 'chat_2',
        'doctorName': 'Dr. Budi Santoso, Sp.A',
        'specialization': 'Spesialis Anak',
        'time': 'Kemarin',
        'status': 'Belum Dimulai',
        'lastMessage': 'Sesi konsultasi akan dimulai sesuai jadwal yang sudah dipilih.',
        'messages': [
          {
            'sender': 'system',
            'text': 'Sesi konsultasi belum dimulai. Silakan tunggu dokter masuk ke ruang chat.',
            'time': 'Kemarin',
          },
        ],
      },
      {
        'id': 'chat_3',
        'doctorName': 'Dr. Citra Lestari, Sp.KK',
        'specialization': 'Kulit dan Kelamin',
        'time': 'Senin',
        'status': 'Selesai',
        'lastMessage': 'Jika gatal belum membaik dalam 5 hari, silakan kontrol ulang.',
        'messages': [
          {
            'sender': 'patient',
            'text': 'Ruam merahnya masih muncul di area tangan, Dok.',
            'time': '10:02',
          },
          {
            'sender': 'doctor',
            'text': 'Oleskan salep dua kali sehari setelah mandi.',
            'time': '10:06',
          },
          {
            'sender': 'doctor',
            'text': 'Jika gatal belum membaik dalam 5 hari, silakan kontrol ulang.',
            'time': '10:08',
          },
        ],
      },
    ];
  }
}

class _SessionStatusBadge extends StatelessWidget {
  final String status;

  const _SessionStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    late final Color backgroundColor;
    late final Color textColor;

    if (status == 'Aktif') {
      backgroundColor = const Color(0xFFE9FBF6);
      textColor = const Color(0xFF20B486);
    } else if (status == 'Selesai') {
      backgroundColor = const Color(0xFFF3F4F6);
      textColor = const Color(0xFF6B7280);
    } else {
      backgroundColor = const Color(0xFFFFF7ED);
      textColor = const Color(0xFFEA580C);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}
