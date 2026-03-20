import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/pharmacy_order_provider.dart';
import '../../providers/prescription_provider.dart';

class RedeemMedicinePage extends ConsumerStatefulWidget {
  final Map<String, dynamic> prescription;

  const RedeemMedicinePage({super.key, required this.prescription});

  @override
  ConsumerState<RedeemMedicinePage> createState() => _RedeemMedicinePageState();
}

class _RedeemMedicinePageState extends ConsumerState<RedeemMedicinePage> {
  String selectedDeliveryMethod = 'Reguler';

  static const List<String> _deliveryMethods = ['Reguler', 'Same Day'];

  @override
  Widget build(BuildContext context) {
    final prescriptionId = widget.prescription['id'] as String?;
    final currentPrescription =
        _findPrescription(ref.watch(prescriptionsProvider), prescriptionId) ??
        widget.prescription;
    final status = currentPrescription['status'] as String? ?? 'Aktif';
    final isRedeemable = status == 'Aktif';
    final medicines = _buildPricedMedicines(
      (currentPrescription['medicines'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>(),
    );
    final subtotal = medicines.fold<int>(
      0,
      (sum, item) => sum + (item['price'] as int? ?? 0),
    );
    final shippingCost = selectedDeliveryMethod == 'Same Day' ? 18000 : 9000;
    final total = subtotal + shippingCost;
    const shippingAddress = {
      'recipient': 'Alwan Maulana',
      'phone': '0812-3456-7890',
      'address': 'Jl. Melati No. 18, Cempaka Putih, Jakarta Pusat',
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Tebus Obat'), centerTitle: false),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: isRedeemable
                  ? () {
                      final orderId = DateTime.now().millisecondsSinceEpoch
                          .toString();
                      final order = {
                        'id': orderId,
                        'prescriptionId': prescriptionId,
                        'orderNumber': _buildOrderNumber(orderId),
                        'orderDate': _buildOrderDate(),
                        'status': 'Menunggu Pembayaran',
                        'doctorName': currentPrescription['doctorName'],
                        'prescriptionDate': currentPrescription['date'],
                        'deliveryMethod': selectedDeliveryMethod,
                        'shippingAddress': shippingAddress,
                        'medicines': medicines,
                        'subtotal': subtotal,
                        'shippingCost': shippingCost,
                        'total': total,
                      };

                      ref.read(pharmacyOrdersProvider.notifier).addOrder(order);
                      if (prescriptionId != null) {
                        ref
                            .read(prescriptionsProvider.notifier)
                            .markAsCompleted(prescriptionId);
                      }
                      context.push('/pharmacy-order-detail', extra: order);
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
              child: const Text(
                'Konfirmasi Tebus Obat',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          _SectionCard(
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
                          medicine['name'] as String? ?? '-',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _InfoRow(
                          label: 'Dosis',
                          value: medicine['dosage'] as String? ?? '-',
                        ),
                        const SizedBox(height: 6),
                        _InfoRow(
                          label: 'Frekuensi',
                          value: medicine['frequency'] as String? ?? '-',
                        ),
                        const SizedBox(height: 6),
                        _InfoRow(
                          label: 'Harga',
                          value: _formatCurrency(
                            medicine['price'] as int? ?? 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),
          const _SectionCard(
            title: 'Alamat Pengiriman',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alwan Maulana',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '0812-3456-7890',
                  style: TextStyle(fontSize: 13, color: Color(0xFF4B5563)),
                ),
                SizedBox(height: 6),
                Text(
                  'Jl. Melati No. 18, Cempaka Putih, Jakarta Pusat',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _SectionCard(
            title: 'Metode Pengiriman',
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _deliveryMethods.map((method) {
                final isSelected = selectedDeliveryMethod == method;

                return InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () {
                    setState(() {
                      selectedDeliveryMethod = method;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF2F80ED)
                          : const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF2F80ED)
                            : const Color(0xFFE5E7EB),
                      ),
                    ),
                    child: Text(
                      method,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF374151),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),
          _SectionCard(
            title: 'Ringkasan Pembayaran',
            child: Column(
              children: [
                _InfoRow(
                  label: 'Subtotal Obat',
                  value: _formatCurrency(subtotal),
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  label: 'Biaya Pengiriman',
                  value: _formatCurrency(shippingCost),
                ),
                const Divider(height: 24),
                _InfoRow(
                  label: 'Total',
                  value: _formatCurrency(total),
                  isTotal: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _buildPricedMedicines(
    List<Map<String, dynamic>> medicines,
  ) {
    const prices = [25000, 18000, 32000, 22000];

    return medicines.asMap().entries.map((entry) {
      return {...entry.value, 'price': prices[entry.key % prices.length]};
    }).toList();
  }

  String _buildOrderNumber(String id) {
    final suffix = id.length > 8 ? id.substring(id.length - 8) : id;
    return 'ORD-$suffix';
  }

  String _buildOrderDate() {
    const monthNames = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    final now = DateTime.now();
    return '${now.day} ${monthNames[now.month]} ${now.year}';
  }

  String _formatCurrency(int value) {
    final digits = value.toString();
    final buffer = StringBuffer();

    for (var i = 0; i < digits.length; i++) {
      final reverseIndex = digits.length - i;
      buffer.write(digits[i]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) {
        buffer.write('.');
      }
    }

    return 'Rp $buffer';
  }
}

Map<String, dynamic>? _findPrescription(
  List<Map<String, dynamic>> prescriptions,
  String? id,
) {
  if (id == null) {
    return null;
  }

  for (final prescription in prescriptions) {
    if (prescription['id'] == id) {
      return prescription;
    }
  }

  return null;
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

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _InfoRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: isTotal ? 15 : 13,
      fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
      color: const Color(0xFF1F2937),
    );

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: textStyle.copyWith(
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: isTotal
                  ? const Color(0xFF1F2937)
                  : const Color(0xFF6B7280),
            ),
          ),
        ),
        Text(value, style: textStyle),
      ],
    );
  }
}
