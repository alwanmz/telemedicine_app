import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/user_address.dart';

final addressProvider =
    StateNotifierProvider<AddressNotifier, List<UserAddress>>(
      (ref) => AddressNotifier(),
    );

final defaultAddressProvider = Provider<UserAddress?>((ref) {
  final addresses = ref.watch(addressProvider);

  for (final address in addresses) {
    if (address.isDefault) {
      return address;
    }
  }

  return null;
});

class AddressNotifier extends StateNotifier<List<UserAddress>> {
  AddressNotifier() : super(_dummyAddresses);

  void addAddress(UserAddress address) {
    final shouldBeDefault = state.isEmpty || address.isDefault;
    final nextAddress = address.copyWith(isDefault: shouldBeDefault);

    if (!shouldBeDefault) {
      state = [...state, nextAddress];
      return;
    }

    state = [
      nextAddress,
      ...state.map((item) => item.copyWith(isDefault: false)),
    ];
  }

  void updateAddress(UserAddress address) {
    final updatedAddresses = state.map((item) {
      if (item.id != address.id) {
        return item;
      }

      return address;
    }).toList();

    state = _ensureSingleDefault(updatedAddresses, preferredId: address.id);
  }

  void setDefaultAddress(String id) {
    state = state.map((address) {
      return address.copyWith(isDefault: address.id == id);
    }).toList();
  }

  static List<UserAddress> _ensureSingleDefault(
    List<UserAddress> addresses, {
    String? preferredId,
  }) {
    var hasDefault = false;
    final normalized = addresses.map((address) {
      if (!address.isDefault) {
        return address;
      }

      if (hasDefault) {
        return address.copyWith(isDefault: false);
      }

      hasDefault = true;
      return address;
    }).toList();

    if (hasDefault) {
      return normalized;
    }

    if (normalized.isEmpty) {
      return normalized;
    }

    return normalized.map((address) {
      final shouldBeDefault =
          preferredId != null ? address.id == preferredId : address == normalized.first;
      return address.copyWith(isDefault: shouldBeDefault);
    }).toList();
  }
}

final List<UserAddress> _dummyAddresses = [
  const UserAddress(
    id: 'addr_1',
    label: 'Rumah',
    recipient: 'Alwan Maulana',
    phone: '0812-3456-7890',
    address: 'Jl. Melati No. 18, Cempaka Putih, Jakarta Pusat',
    isDefault: true,
  ),
  const UserAddress(
    id: 'addr_2',
    label: 'Kantor',
    recipient: 'Alwan Maulana',
    phone: '0812-9988-7766',
    address: 'Jl. Jenderal Sudirman Kav. 10, Jakarta Selatan',
  ),
];
