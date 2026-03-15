import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorDetailPage extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorDetailPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final doctorName = doctor['name'] as String? ?? '-';
    final specialization = doctor['specialization'] as String? ?? '-';
    final hospitalName = doctor['hospital'] as String? ?? '-';
    final experience = doctor['experience'] as String? ?? '-';
    final rating = doctor['rating'] as double? ?? 0.0;
    final isAvailable = doctor['available'] as bool? ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Dokter'), centerTitle: false),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: isAvailable
                  ? () {
                      context.push('/booking', extra: doctor);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F80ED),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(
                isAvailable ? 'Buat Janji' : 'Jadwal Penuh',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Column(
              children: [
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF4FF),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 42,
                    color: Color(0xFF2F80ED),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  doctorName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  specialization,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2F80ED),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  hospitalName,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFF5A623),
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF374151),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.work_outline_rounded,
                      size: 18,
                      color: Color(0xFF9CA3AF),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      experience,
                      style: const TextStyle(color: Color(0xFF6B7280)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _InfoCard(
            title: 'Tentang Dokter',
            child: Text(
              '$doctorName adalah dokter $specialization yang melayani konsultasi telemedicine dan kunjungan rawat jalan. Cocok untuk konsultasi awal, kontrol rutin, dan tindak lanjut terapi.',
              style: const TextStyle(
                fontSize: 13,
                height: 1.6,
                color: Color(0xFF4B5563),
              ),
            ),
          ),
          const SizedBox(height: 14),
          _InfoCard(
            title: 'Jadwal Praktik',
            child: Column(
              children: const [
                _ScheduleRow(day: 'Senin', time: '09:00 - 12:00'),
                SizedBox(height: 10),
                _ScheduleRow(day: 'Rabu', time: '13:00 - 16:00'),
                SizedBox(height: 10),
                _ScheduleRow(day: 'Jumat', time: '10:00 - 14:00'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _InfoCard(
            title: 'Biaya Konsultasi',
            child: Row(
              children: const [
                Icon(Icons.payments_outlined, color: Color(0xFF20B486)),
                SizedBox(width: 10),
                Text(
                  'Rp 75.000 / sesi',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _InfoCard({required this.title, required this.child});

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
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _ScheduleRow extends StatelessWidget {
  final String day;
  final String time;

  const _ScheduleRow({required this.day, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            day,
            style: const TextStyle(fontSize: 13, color: Color(0xFF374151)),
          ),
        ),
        Text(
          time,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
      ],
    );
  }
}
