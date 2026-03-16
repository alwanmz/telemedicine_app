import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/appointment_provider.dart';

class BookingPage extends ConsumerStatefulWidget {
  final Map<String, dynamic> doctor;

  const BookingPage({super.key, required this.doctor});

  @override
  ConsumerState<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends ConsumerState<BookingPage> {
  String selectedDate = 'Senin, 18 Maret 2026';
  String selectedTime = '09:00';
  String selectedConsultationType = 'Chat';
  String selectedPatientType = 'Umum';
  String selectedPaymentMethod = 'Tunai';
  final TextEditingController complaintController = TextEditingController();
  final TextEditingController allergyHistoryController =
      TextEditingController();
  final TextEditingController bloodPressureController =
      TextEditingController();
  final TextEditingController bodyTemperatureController =
      TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  final List<String> dates = [
    'Senin, 18 Maret 2026',
    'Selasa, 19 Maret 2026',
    'Rabu, 20 Maret 2026',
  ];

  final List<String> times = ['09:00', '10:00', '11:00', '13:00', '14:00'];

  final List<String> consultationTypes = ['Chat', 'Voice Call', 'Video Call'];
  final List<String> patientTypes = ['Umum', 'Asuransi', 'BPJS'];
  final List<String> paymentMethods = [
    'Tunai',
    'Transfer Bank',
    'E-Wallet',
  ];

  @override
  void dispose() {
    complaintController.dispose();
    allergyHistoryController.dispose();
    bloodPressureController.dispose();
    bodyTemperatureController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final doctorName = widget.doctor['name'] as String? ?? '-';
    final specialization = widget.doctor['specialization'] as String? ?? '-';
    final hospitalName = widget.doctor['hospital'] as String? ?? '-';
    final rating = widget.doctor['rating'] as double? ?? 0.0;

    return Scaffold(
      appBar: AppBar(title: const Text('Buat Janji'), centerTitle: false),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                final appointmentId =
                    DateTime.now().millisecondsSinceEpoch.toString();
                final invoiceNumber = _buildInvoiceNumber(appointmentId);

                final appointment = {
                  'id': appointmentId,
                  'doctorName': doctorName,
                  'specialization': specialization,
                  'hospital': hospitalName,
                  'date': selectedDate,
                  'time': selectedTime,
                  'consultationType': selectedConsultationType,
                  'patientType': selectedPatientType,
                  'complaint': complaintController.text.trim(),
                  'allergyHistory': allergyHistoryController.text.trim(),
                  'bloodPressure': bloodPressureController.text.trim(),
                  'bodyTemperature': bodyTemperatureController.text.trim(),
                  'weight': weightController.text.trim(),
                  'height': heightController.text.trim(),
                  'paymentMethod': selectedPaymentMethod,
                  'paymentStatus': _resolvePaymentStatus(selectedPaymentMethod),
                  'invoiceNumber': invoiceNumber,
                  'totalPrice': 'Rp 80.000',
                  'status': 'Terjadwal',
                };

                ref
                    .read(appointmentsProvider.notifier)
                    .addAppointment(appointment);

                context.push('/booking-success', extra: appointment);
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
                'Konfirmasi Janji',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
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
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: Color(0xFFF5A623),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF374151),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Pilih Tanggal',
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: dates.map((date) {
                final isSelected = selectedDate == date;
                return _SelectableChip(
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
          ),
          const SizedBox(height: 14),
          _SectionCard(
            title: 'Pilih Jam',
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: times.map((time) {
                final isSelected = selectedTime == time;
                return _SelectableChip(
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
          ),
          const SizedBox(height: 14),
          _SectionCard(
            title: 'Metode Konsultasi',
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: consultationTypes.map((type) {
                final isSelected = selectedConsultationType == type;
                return _SelectableChip(
                  label: type,
                  isSelected: isSelected,
                  compact: true,
                  onTap: () {
                    setState(() {
                      selectedConsultationType = type;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),
          _SectionCard(
            title: 'Tipe Pasien',
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: patientTypes.map((type) {
                final isSelected = selectedPatientType == type;
                return _SelectableChip(
                  label: type,
                  isSelected: isSelected,
                  compact: true,
                  onTap: () {
                    setState(() {
                      selectedPatientType = type;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),
          _SectionCard(
            title: 'Keluhan Utama',
            child: TextField(
              controller: complaintController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Tulis keluhan atau alasan konsultasi...',
                filled: true,
                fillColor: const Color(0xFFF9FAFB),
                contentPadding: const EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: Color(0xFF2F80ED)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          _SectionCard(
            title: 'Informasi Medis',
            child: Column(
              children: [
                _InputField(
                  controller: allergyHistoryController,
                  label: 'Riwayat Alergi',
                  hintText: 'Contoh: Tidak ada / Alergi penisilin',
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _InputField(
                        controller: bloodPressureController,
                        label: 'Tekanan Darah',
                        hintText: '120/80',
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _InputField(
                        controller: bodyTemperatureController,
                        label: 'Suhu Tubuh',
                        hintText: '36.8 C',
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _InputField(
                        controller: weightController,
                        label: 'Berat Badan',
                        hintText: '55 kg',
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _InputField(
                        controller: heightController,
                        label: 'Tinggi Badan',
                        hintText: '165 cm',
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _SectionCard(
            title: 'Metode Pembayaran',
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: paymentMethods.map((method) {
                final isSelected = selectedPaymentMethod == method;
                return _SelectableChip(
                  label: method,
                  isSelected: isSelected,
                  compact: true,
                  onTap: () {
                    setState(() {
                      selectedPaymentMethod = method;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),
          const _SectionCard(
            title: 'Ringkasan Biaya',
            child: Column(
              children: [
                _PriceRow(label: 'Biaya Konsultasi', value: 'Rp 75.000'),
                SizedBox(height: 10),
                _PriceRow(label: 'Biaya Layanan', value: 'Rp 5.000'),
                Divider(height: 24),
                _PriceRow(label: 'Total', value: 'Rp 80.000', isTotal: true),
              ],
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  String _resolvePaymentStatus(String paymentMethod) {
    if (paymentMethod == 'Tunai') return 'unpaid';
    return 'pending';
  }

  String _buildInvoiceNumber(String appointmentId) {
    final suffix = appointmentId.length > 8
        ? appointmentId.substring(appointmentId.length - 8)
        : appointmentId;
    return 'INV-$suffix';
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final int maxLines;
  final TextInputType keyboardType;

  const _InputField({
    required this.controller,
    required this.label,
    required this.hintText,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xFF2F80ED)),
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

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
          child,
        ],
      ),
    );
  }
}

class _SelectableChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool compact;

  const _SelectableChip({
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

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _PriceRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: isTotal ? 15 : 13,
      fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
      color: const Color(0xFF1F2937),
    );

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: style.copyWith(
              color: isTotal
                  ? const Color(0xFF1F2937)
                  : const Color(0xFF6B7280),
            ),
          ),
        ),
        Text(value, style: style),
      ],
    );
  }
}
