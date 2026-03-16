import 'package:flutter/material.dart';

class ChatRoomPage extends StatelessWidget {
  final Map<String, dynamic> session;

  const ChatRoomPage({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final doctorName = session['doctorName'] as String? ?? '-';
    final specialization = session['specialization'] as String? ?? '-';
    final status = session['status'] as String? ?? 'Belum Dimulai';
    final messages =
        (session['messages'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>();

    return Scaffold(
      appBar: AppBar(title: const Text('Ruang Konsultasi'), centerTitle: false),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Balasan chat masih menggunakan data dummy.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF4FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Kirim',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2F80ED),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF4FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Color(0xFF2F80ED),
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctorName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          specialization,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2F80ED),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _SessionStatusBadge(status: status),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              itemCount: messages.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final message = messages[index];
                final sender = message['sender'] as String? ?? 'system';
                final isPatient = sender == 'patient';
                final isDoctor = sender == 'doctor';

                return Align(
                  alignment: isPatient
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.74,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isPatient
                            ? const Color(0xFF2F80ED)
                            : isDoctor
                            ? Colors.white
                            : const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          topRight: const Radius.circular(20),
                          bottomLeft: Radius.circular(isPatient ? 20 : 8),
                          bottomRight: Radius.circular(isPatient ? 8 : 20),
                        ),
                        border: Border.all(
                          color: isDoctor || !isPatient
                              ? const Color(0xFFE5E7EB)
                              : const Color(0xFF2F80ED),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isDoctor
                                ? 'Dokter'
                                : isPatient
                                ? 'Anda'
                                : 'Sistem',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: isPatient
                                  ? Colors.white.withValues(alpha: 0.9)
                                  : const Color(0xFF6B7280),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            message['text'] as String? ?? '-',
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.5,
                              color: isPatient
                                  ? Colors.white
                                  : const Color(0xFF374151),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            message['time'] as String? ?? '-',
                            style: TextStyle(
                              fontSize: 11,
                              color: isPatient
                                  ? Colors.white.withValues(alpha: 0.75)
                                  : const Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
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
