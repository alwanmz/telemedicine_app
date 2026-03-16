import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrescriptionsPage extends StatelessWidget {
  const PrescriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prescriptions = _dummyPrescriptions;

    return Scaffold(
      appBar: AppBar(title: const Text('Resep Saya'), centerTitle: false),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        itemCount: prescriptions.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final prescription = prescriptions[index];
          final status = prescription['status'] as String? ?? 'Aktif';

          return InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              context.push('/prescription-detail', extra: prescription);
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
                      Icons.receipt_long_rounded,
                      color: Color(0xFF2F80ED),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          prescription['doctorName'] as String? ?? '-',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          prescription['date'] as String? ?? '-',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _PrescriptionStatusBadge(status: status),
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
}

const List<Map<String, dynamic>> _dummyPrescriptions = [
  {
    'id': 'rx_1',
    'doctorName': 'Dr. Amanda Putri, Sp.PD',
    'date': '17 Maret 2026',
    'status': 'Aktif',
    'notes':
        'Minum obat setelah makan dan perbanyak istirahat. Jika tekanan darah tetap tinggi, lakukan kontrol ulang.',
    'medicines': [
      {
        'name': 'Amlodipine 5 mg',
        'dosage': '1 tablet',
        'frequency': '1x sehari setelah sarapan',
      },
      {
        'name': 'Paracetamol 500 mg',
        'dosage': '1 tablet',
        'frequency': '3x sehari bila perlu',
      },
    ],
  },
  {
    'id': 'rx_2',
    'doctorName': 'Dr. Budi Santoso, Sp.A',
    'date': '15 Maret 2026',
    'status': 'Menunggu Tebus',
    'notes':
        'Obat diberikan untuk menurunkan demam dan membantu pemulihan. Pastikan anak cukup minum.',
    'medicines': [
      {
        'name': 'Sirup Paracetamol',
        'dosage': '5 ml',
        'frequency': '3x sehari',
      },
      {
        'name': 'Vitamin C Anak',
        'dosage': '1 tablet kunyah',
        'frequency': '1x sehari',
      },
    ],
  },
  {
    'id': 'rx_3',
    'doctorName': 'Dr. Citra Lestari, Sp.KK',
    'date': '10 Maret 2026',
    'status': 'Selesai',
    'notes':
        'Lanjutkan perawatan kulit dan hindari sabun dengan bahan iritatif selama masa pengobatan.',
    'medicines': [
      {
        'name': 'Cetirizine 10 mg',
        'dosage': '1 tablet',
        'frequency': '1x malam hari',
      },
      {
        'name': 'Krim Hydrocortisone',
        'dosage': 'Oles tipis',
        'frequency': '2x sehari',
      },
    ],
  },
];

class _PrescriptionStatusBadge extends StatelessWidget {
  final String status;

  const _PrescriptionStatusBadge({required this.status});

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
