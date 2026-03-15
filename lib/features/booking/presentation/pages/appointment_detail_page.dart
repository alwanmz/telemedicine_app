import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppointmentDetailPage extends StatelessWidget {
  final Map<String, dynamic> appointment;

  const AppointmentDetailPage({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final doctorName = appointment['doctorName'] as String? ?? '-';
    final specialization = appointment['specialization'] as String? ?? '-';
    final hospitalName = appointment['hospital'] as String? ?? '-';
    final date = appointment['date'] as String? ?? '-';
    final time = appointment['time'] as String? ?? '-';
    final consultationType = appointment['consultationType'] as String? ?? '-';
    final complaint = appointment['complaint'] as String? ?? '-';
    final totalPrice = appointment['totalPrice'] as String? ?? 'Rp 80.000';
    final status = appointment['status'] as String? ?? 'Terjadwal';

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Janji'), centerTitle: false),
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
            child: Row(
              children: [
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF4FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 34,
                    color: Color(0xFF2F80ED),
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
                      const SizedBox(height: 4),
                      Text(
                        hospitalName,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _DetailCard(
            title: 'Informasi Janji',
            children: [
              _DetailRow(label: 'Tanggal', value: date),
              _DetailRow(label: 'Jam', value: time),
              _DetailRow(label: 'Metode Konsultasi', value: consultationType),
              _DetailRow(
                label: 'Status',
                value: status,
                valueColor: const Color(0xFF20B486),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _DetailCard(
            title: 'Keluhan Utama',
            children: [
              Text(
                complaint.isEmpty ? '-' : complaint,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Color(0xFF4B5563),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _DetailCard(
            title: 'Pembayaran',
            children: [
              _DetailRow(label: 'Total Biaya', value: totalPrice),
              _DetailRow(label: 'Metode Bayar', value: 'Belum dipilih'),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _DetailCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: valueColor ?? const Color(0xFF1F2937),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
