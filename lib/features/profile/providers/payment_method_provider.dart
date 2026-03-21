import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/saved_payment_method.dart';

final paymentMethodProvider =
    StateNotifierProvider<PaymentMethodNotifier, List<SavedPaymentMethod>>(
      (ref) => PaymentMethodNotifier(),
    );

final defaultPaymentMethodProvider = Provider<SavedPaymentMethod?>((ref) {
  final methods = ref.watch(paymentMethodProvider);

  for (final method in methods) {
    if (method.isDefault) {
      return method;
    }
  }

  return null;
});

class PaymentMethodNotifier extends StateNotifier<List<SavedPaymentMethod>> {
  PaymentMethodNotifier() : super(_dummyPaymentMethods);

  void setDefaultMethod(String id) {
    state = state.map((method) {
      return method.copyWith(isDefault: method.id == id);
    }).toList();
  }
}

final List<SavedPaymentMethod> _dummyPaymentMethods = [
  const SavedPaymentMethod(
    id: 'pm_1',
    type: SavedPaymentMethod.typeBankTransfer,
    label: 'BCA Virtual Account',
    accountName: 'Alwan Maulana',
    accountNumber: '0147 8899 2211',
    isDefault: true,
  ),
  const SavedPaymentMethod(
    id: 'pm_2',
    type: SavedPaymentMethod.typeEWallet,
    label: 'GoPay',
    accountName: 'Alwan Maulana',
    accountNumber: '0812 3456 7890',
  ),
  const SavedPaymentMethod(
    id: 'pm_3',
    type: SavedPaymentMethod.typeCash,
    label: 'Bayar Tunai Saat Diterima',
    accountName: 'Alwan Maulana',
    accountNumber: '-',
  ),
];
