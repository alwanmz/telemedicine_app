import '../../prescriptions/models/shipping_address.dart';

class UserAddress {
  final String id;
  final String label;
  final String recipient;
  final String phone;
  final String address;
  final bool isDefault;

  const UserAddress({
    required this.id,
    required this.label,
    required this.recipient,
    required this.phone,
    required this.address,
    this.isDefault = false,
  });

  factory UserAddress.fromMap(Map<String, dynamic> map) {
    return UserAddress(
      id: map['id'] as String? ?? '',
      label: map['label'] as String? ?? 'Alamat',
      recipient: map['recipient'] as String? ?? '-',
      phone: map['phone'] as String? ?? '-',
      address: map['address'] as String? ?? '-',
      isDefault: map['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'recipient': recipient,
      'phone': phone,
      'address': address,
      'isDefault': isDefault,
    };
  }

  UserAddress copyWith({
    String? id,
    String? label,
    String? recipient,
    String? phone,
    String? address,
    bool? isDefault,
  }) {
    return UserAddress(
      id: id ?? this.id,
      label: label ?? this.label,
      recipient: recipient ?? this.recipient,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  ShippingAddress toShippingAddress() {
    return ShippingAddress(
      recipient: recipient,
      phone: phone,
      address: address,
    );
  }
}
