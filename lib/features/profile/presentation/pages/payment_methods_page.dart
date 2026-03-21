import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/saved_payment_method.dart';
import '../../providers/payment_method_provider.dart';

class PaymentMethodsPage extends ConsumerWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final methods = ref.watch(paymentMethodProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Metode Pembayaran'),
        centerTitle: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        itemCount: methods.length,
        separatorBuilder: (_, _) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final method = methods[index];

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
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF4FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        _iconForType(method.type),
                        color: const Color(0xFF2F80ED),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            method.label,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            method.typeLabel,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (method.isDefault)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9FBF6),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Text(
                          'Utama',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF20B486),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 14),
                _InfoRow(label: 'Atas Nama', value: method.accountName),
                const SizedBox(height: 8),
                _InfoRow(label: 'Nomor', value: method.accountNumber),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: method.isDefault
                        ? null
                        : () {
                            ref
                                .read(paymentMethodProvider.notifier)
                                .setDefaultMethod(method.id);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F80ED),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: const Color(0xFFEAF4FF),
                      disabledForegroundColor: const Color(0xFF2F80ED),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      method.isDefault
                          ? 'Metode Pembayaran Utama'
                          : 'Jadikan Utama',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static IconData _iconForType(String type) {
    if (type == SavedPaymentMethod.typeCash) {
      return Icons.payments_rounded;
    }
    if (type == SavedPaymentMethod.typeBankTransfer) {
      return Icons.account_balance_rounded;
    }
    return Icons.account_balance_wallet_rounded;
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
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF6B7280),
            ),
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
