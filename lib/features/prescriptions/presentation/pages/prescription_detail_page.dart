import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/prescription.dart';
import '../../providers/prescription_provider.dart';

class PrescriptionDetailPage extends ConsumerWidget {
  final Prescription prescription;

  const PrescriptionDetailPage({super.key, required this.prescription});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prescriptionId = prescription.id;
    final currentPrescription =
        _findPrescription(ref.watch(prescriptionsProvider), prescriptionId) ??
        prescription;
    final doctorName = currentPrescription.doctorName;
    final date = currentPrescription.date;
    final status = currentPrescription.status;
    final isRedeemable = currentPrescription.isRedeemable;
    final actionLabel = isRedeemable ? 'Tebus Obat' : 'Resep Sudah Selesai';
    final notes = currentPrescription.notes;
    final medicines = currentPrescription.medicines;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Resep'), centerTitle: false),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed:
                  isRedeemable
                      ? () {
                        context.push(
                          '/redeem-medicine',
                          extra: currentPrescription,
                        );
                      }
                      : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F80ED),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(0xFFF3F4F6),
                disabledForegroundColor: const Color(0xFF6B7280),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(
                actionLabel,
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
          _DetailCard(
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
                    Icons.receipt_long_rounded,
                    size: 32,
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
                        date,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _PrescriptionStatusBadge(status: status),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _DetailCard(
            title: 'Daftar Obat',
            child: Column(
              children: medicines.map((medicine) {
                final isLast = medicine == medicines.last;

                return Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medicine.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _InfoRow(
                          label: 'Dosis',
                          value: medicine.dosage,
                        ),
                        const SizedBox(height: 6),
                        _InfoRow(
                          label: 'Frekuensi',
                          value: medicine.frequency,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),
          _DetailCard(
            title: 'Catatan Dokter',
            child: Text(
              notes,
              style: const TextStyle(
                fontSize: 13,
                height: 1.6,
                color: Color(0xFF4B5563),
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

Prescription? _findPrescription(
  List<Prescription> prescriptions,
  String id,
) {
  for (final prescription in prescriptions) {
    if (prescription.id == id) {
      return prescription;
    }
  }

  return null;
}

class _DetailCard extends StatelessWidget {
  final String? title;
  final Widget child;

  const _DetailCard({this.title, required this.child});

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
          if (title != null) ...[
            Text(
              title!,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 14),
          ],
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.right,
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
    } else if (status == Prescription.statusActive) {
      backgroundColor = const Color(0xFFE9FBF6);
      textColor = const Color(0xFF20B486);
    } else if (status == 'Selesai' || status == Prescription.statusCompleted) {
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
        Prescription.labelForStatus(status),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}
