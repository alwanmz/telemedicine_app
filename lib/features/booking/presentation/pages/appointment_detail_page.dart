import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/appointment_provider.dart';

class AppointmentDetailPage extends ConsumerWidget {
  final String appointmentId;

  const AppointmentDetailPage({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointments = ref.watch(appointmentsProvider);

    final Map<String, dynamic>? appointment = appointments
        .cast<Map<String, dynamic>?>()
        .firstWhere((item) => item?['id'] == appointmentId, orElse: () => null);

    if (appointment == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Janji'), centerTitle: false),
        body: const Center(
          child: Text(
            'Data janji tidak ditemukan.',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
          ),
        ),
      );
    }

    final id = appointment['id'] as String? ?? '';
    final doctorName = appointment['doctorName'] as String? ?? '-';
    final specialization = appointment['specialization'] as String? ?? '-';
    final hospitalName = appointment['hospital'] as String? ?? '-';
    final date = appointment['date'] as String? ?? '-';
    final time = appointment['time'] as String? ?? '-';
    final consultationType = appointment['consultationType'] as String? ?? '-';
    final patientType = appointment['patientType'] as String? ?? '-';
    final complaint = appointment['complaint'] as String? ?? '-';
    final allergyHistory = appointment['allergyHistory'] as String? ?? '-';
    final bloodPressure = appointment['bloodPressure'] as String? ?? '-';
    final bodyTemperature = appointment['bodyTemperature'] as String? ?? '-';
    final weight = appointment['weight'] as String? ?? '-';
    final height = appointment['height'] as String? ?? '-';
    final paymentMethod = appointment['paymentMethod'] as String? ?? '-';
    final invoiceNumber = appointment['invoiceNumber'] as String? ?? '-';
    final paymentStatus = _resolvePaymentStatus(
      appointment['paymentStatus'] as String?,
      paymentMethod,
    );
    final totalPrice = appointment['totalPrice'] as String? ?? 'Rp 80.000';
    final status = appointment['status'] as String? ?? 'Terjadwal';

    final isCancelled = status == 'Dibatalkan';

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Janji'), centerTitle: false),
      bottomNavigationBar: isCancelled
          ? null
          : SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final result =
                              await showModalBottomSheet<Map<String, String>>(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(28),
                                  ),
                                ),
                                builder: (context) => const _RescheduleSheet(),
                              );

                          if (result != null) {
                            ref
                                .read(appointmentsProvider.notifier)
                                .rescheduleAppointment(
                                  id: id,
                                  newDate: result['date']!,
                                  newTime: result['time']!,
                                );

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Jadwal berhasil diubah'),
                                ),
                              );
                            }
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF2F80ED),
                          side: const BorderSide(color: Color(0xFFE5E7EB)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          minimumSize: const Size.fromHeight(54),
                        ),
                        child: const Text(
                          'Jadwal Ulang',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: const Text('Batalkan Janji'),
                              content: const Text(
                                'Yakin ingin membatalkan janji ini?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('Tidak'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Ya, Batalkan'),
                                ),
                              ],
                            ),
                          );

                          if (confirmed == true) {
                            ref
                                .read(appointmentsProvider.notifier)
                                .cancelAppointment(id);

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Janji berhasil dibatalkan'),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          minimumSize: const Size.fromHeight(54),
                        ),
                        child: const Text(
                          'Batalkan',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
              _DetailRow(label: 'Tipe Pasien', value: patientType),
              _DetailRow(
                label: 'Status',
                value: status,
                valueColor: _statusColor(status),
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
            title: 'Data Intake',
            children: [
              _DetailRow(
                label: 'Tekanan Darah',
                value: bloodPressure.isEmpty ? '-' : bloodPressure,
              ),
              _DetailRow(
                label: 'Suhu Tubuh',
                value: bodyTemperature.isEmpty ? '-' : bodyTemperature,
              ),
              _DetailRow(
                label: 'Berat Badan',
                value: weight.isEmpty ? '-' : weight,
              ),
              _DetailRow(
                label: 'Tinggi Badan',
                value: height.isEmpty ? '-' : height,
              ),
              const SizedBox(height: 6),
              const Text(
                'Riwayat Alergi',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                allergyHistory.isEmpty ? '-' : allergyHistory,
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
              _DetailRow(label: 'No. Invoice', value: invoiceNumber),
              _DetailRow(label: 'Total Biaya', value: totalPrice),
              _DetailRow(
                label: 'Metode Bayar',
                value: paymentMethod.isEmpty ? '-' : paymentMethod,
              ),
              _DetailWidgetRow(
                label: 'Status Pembayaran',
                child: _PaymentStatusBadge(status: paymentStatus),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    if (status == 'Dibatalkan') return const Color(0xFFDC2626);
    if (status == 'Dijadwalkan Ulang') return const Color(0xFFEA580C);
    return const Color(0xFF20B486);
  }

  String _resolvePaymentStatus(String? rawStatus, String paymentMethod) {
    if (rawStatus != null && rawStatus.isNotEmpty) return rawStatus;
    if (paymentMethod == 'Tunai') return 'unpaid';
    if (paymentMethod == 'Transfer Bank' || paymentMethod == 'E-Wallet') {
      return 'pending';
    }
    return '-';
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

class _DetailWidgetRow extends StatelessWidget {
  final String label;
  final Widget child;

  const _DetailWidgetRow({required this.label, required this.child});

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
          child,
        ],
      ),
    );
  }
}

class _PaymentStatusBadge extends StatelessWidget {
  final String status;

  const _PaymentStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    late final Color backgroundColor;
    late final Color textColor;
    late final String label;

    if (status == 'unpaid') {
      backgroundColor = const Color(0xFFFEF2F2);
      textColor = const Color(0xFFDC2626);
      label = 'Belum Dibayar';
    } else if (status == 'pending') {
      backgroundColor = const Color(0xFFFFF7ED);
      textColor = const Color(0xFFEA580C);
      label = 'Menunggu';
    } else {
      backgroundColor = const Color(0xFFF3F4F6);
      textColor = const Color(0xFF6B7280);
      label = '-';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}

class _RescheduleSheet extends StatefulWidget {
  const _RescheduleSheet();

  @override
  State<_RescheduleSheet> createState() => _RescheduleSheetState();
}

class _RescheduleSheetState extends State<_RescheduleSheet> {
  String selectedDate = 'Selasa, 19 Maret 2026';
  String selectedTime = '10:00';

  final List<String> dates = const [
    'Selasa, 19 Maret 2026',
    'Rabu, 20 Maret 2026',
    'Kamis, 21 Maret 2026',
  ];

  final List<String> times = const [
    '09:00',
    '10:00',
    '11:00',
    '13:00',
    '14:00',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Jadwal Ulang',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: dates.map((date) {
              final isSelected = selectedDate == date;
              return _SheetChip(
                label: date,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    selectedDate = date;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: times.map((time) {
              final isSelected = selectedTime == time;
              return _SheetChip(
                label: time,
                isSelected: isSelected,
                compact: true,
                onTap: () {
                  setState(() {
                    selectedTime = time;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'date': selectedDate,
                  'time': selectedTime,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F80ED),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                'Simpan Jadwal Baru',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SheetChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool compact;

  const _SheetChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 14 : 16,
          vertical: compact ? 10 : 12,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2F80ED) : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2F80ED)
                : const Color(0xFFE5E7EB),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF374151),
          ),
        ),
      ),
    );
  }
}
