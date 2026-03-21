import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/pharmacy_order.dart';
import '../../providers/pharmacy_order_provider.dart';

class PharmacyOrderDetailPage extends ConsumerWidget {
  final PharmacyOrder order;

  const PharmacyOrderDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderId = order.id;
    final orders = ref.watch(pharmacyOrdersProvider);
    final currentOrder = _findOrder(orders, orderId) ?? order;
    final orderNumber = currentOrder.orderNumber;
    final paymentStatus = currentOrder.paymentStatus;
    final fulfillmentStatus = currentOrder.fulfillmentStatus;
    final doctorName = currentOrder.doctorName;
    final prescriptionDate = currentOrder.prescriptionDate;
    final deliveryMethod = currentOrder.deliveryMethod;
    final shippingAddress = currentOrder.shippingAddress;
    final medicines = currentOrder.medicines;
    final actionLabel = _actionLabel(fulfillmentStatus);
    final nextStatus = _nextStatus(fulfillmentStatus);

    return Scaffold(
      appBar: AppBar(title: const Text('Lacak Pesanan'), centerTitle: false),
      bottomNavigationBar:
          actionLabel == null || nextStatus == null
          ? null
          : SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      final notifier = ref.read(pharmacyOrdersProvider.notifier);

                      if (fulfillmentStatus ==
                          PharmacyOrder.fulfillmentStatusWaitingPayment) {
                        notifier.markOrderAsPaid(orderId);
                      } else {
                        notifier.updateFulfillmentStatus(
                          id: orderId,
                          fulfillmentStatus: nextStatus,
                        );
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Status pesanan berhasil diperbarui'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F80ED),
                      foregroundColor: Colors.white,
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
          _SectionCard(
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
                    Icons.local_pharmacy_rounded,
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
                        orderNumber,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Resep dari $doctorName \u2022 $prescriptionDate',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _PaymentStatusBadge(status: paymentStatus),
                          _FulfillmentStatusBadge(status: fulfillmentStatus),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _SectionCard(
            title: 'Status Order',
            child: Column(
              children: [
                _StatusRow(
                  label: 'Pembayaran',
                  child: _PaymentStatusBadge(status: paymentStatus),
                ),
                const SizedBox(height: 12),
                _StatusRow(
                  label: 'Pemenuhan',
                  child: _FulfillmentStatusBadge(status: fulfillmentStatus),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _SectionCard(
            title: 'Status Pemenuhan',
            child: Column(
              children: _statuses.map((item) {
                final currentIndex = _statuses.indexOf(fulfillmentStatus);
                final index = _statuses.indexOf(item);
                final isActive = item == fulfillmentStatus;
                final isPassed = currentIndex != -1 && index < currentIndex;

                return Padding(
                  padding: EdgeInsets.only(bottom: item == _statuses.last ? 0 : 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isActive || isPassed
                              ? const Color(0xFF2F80ED)
                              : const Color(0xFFF3F4F6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isActive || isPassed
                              ? Icons.check_rounded
                              : Icons.circle,
                          size: 14,
                          color: isActive || isPassed
                              ? Colors.white
                              : const Color(0xFFD1D5DB),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            _fulfillmentStatusLabel(item),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight:
                                  isActive ? FontWeight.w700 : FontWeight.w500,
                              color: isActive || isPassed
                                  ? const Color(0xFF1F2937)
                                  : const Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),
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
          _SectionCard(
            title: 'Info Pengiriman',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoRow(label: 'Metode', value: deliveryMethod),
                const SizedBox(height: 10),
                Text(
                  shippingAddress.recipient,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  shippingAddress.phone,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF4B5563),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  shippingAddress.address,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const List<String> _statuses = [
    PharmacyOrder.fulfillmentStatusWaitingPayment,
    PharmacyOrder.fulfillmentStatusProcessing,
    PharmacyOrder.fulfillmentStatusShipped,
    PharmacyOrder.fulfillmentStatusCompleted,
  ];

  static String? _actionLabel(String status) {
    if (status == PharmacyOrder.fulfillmentStatusWaitingPayment) {
      return 'Tandai Dibayar';
    }
    if (status == PharmacyOrder.fulfillmentStatusProcessing) {
      return 'Tandai Dikirim';
    }
    if (status == PharmacyOrder.fulfillmentStatusShipped) {
      return 'Tandai Selesai';
    }
    return null;
  }

  static String? _nextStatus(String status) {
    if (status == PharmacyOrder.fulfillmentStatusWaitingPayment) {
      return PharmacyOrder.fulfillmentStatusProcessing;
    }
    if (status == PharmacyOrder.fulfillmentStatusProcessing) {
      return PharmacyOrder.fulfillmentStatusShipped;
    }
    if (status == PharmacyOrder.fulfillmentStatusShipped) {
      return PharmacyOrder.fulfillmentStatusCompleted;
    }
    return null;
  }

  static String _fulfillmentStatusLabel(String status) {
    return PharmacyOrder.labelForFulfillmentStatus(status);
  }
}

PharmacyOrder? _findOrder(
  List<PharmacyOrder> orders,
  String orderId,
) {
  for (final item in orders) {
    if (item.id == orderId) {
      return item;
    }
  }

  return null;
}

class _SectionCard extends StatelessWidget {
  final String? title;
  final Widget child;

  const _SectionCard({this.title, required this.child});

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

class _StatusRow extends StatelessWidget {
  final String label;
  final Widget child;

  const _StatusRow({required this.label, required this.child});

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
        child,
      ],
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

    if (status == PharmacyOrder.paymentStatusPaid) {
      backgroundColor = const Color(0xFFE9FBF6);
      textColor = const Color(0xFF20B486);
    } else if (status == PharmacyOrder.paymentStatusPending) {
      backgroundColor = const Color(0xFFFFF7ED);
      textColor = const Color(0xFFEA580C);
    } else if (status == PharmacyOrder.paymentStatusFailed) {
      backgroundColor = const Color(0xFFFEF2F2);
      textColor = const Color(0xFFDC2626);
    } else {
      backgroundColor = const Color(0xFFFEF2F2);
      textColor = const Color(0xFFDC2626);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        PharmacyOrder.labelForPaymentStatus(status),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}

class _FulfillmentStatusBadge extends StatelessWidget {
  final String status;

  const _FulfillmentStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    late final Color backgroundColor;
    late final Color textColor;

    if (status == PharmacyOrder.fulfillmentStatusCompleted) {
      backgroundColor = const Color(0xFFE9FBF6);
      textColor = const Color(0xFF20B486);
    } else if (status == PharmacyOrder.fulfillmentStatusShipped) {
      backgroundColor = const Color(0xFFEAF4FF);
      textColor = const Color(0xFF2F80ED);
    } else if (status == PharmacyOrder.fulfillmentStatusProcessing) {
      backgroundColor = const Color(0xFFFFF7ED);
      textColor = const Color(0xFFEA580C);
    } else {
      backgroundColor = const Color(0xFFFEF2F2);
      textColor = const Color(0xFFDC2626);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        PharmacyOrder.labelForFulfillmentStatus(status),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}
