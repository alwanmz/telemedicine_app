import 'package:flutter/material.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Janji Temu'), centerTitle: false),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _AppointmentCard(
            doctorName: 'Dr. Amanda Putri, Sp.PD',
            schedule: 'Senin, 18 Maret 2026 • 09:30 WIB',
            status: 'Terjadwal',
          ),
          const SizedBox(height: 12),
          _AppointmentCard(
            doctorName: 'Dr. Budi Santoso, Sp.A',
            schedule: 'Rabu, 20 Maret 2026 • 13:00 WIB',
            status: 'Menunggu Konfirmasi',
          ),
        ],
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String schedule;
  final String status;

  const _AppointmentCard({
    required this.doctorName,
    required this.schedule,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doctorName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            schedule,
            style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF4FF),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Color(0xFF2F80ED),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
