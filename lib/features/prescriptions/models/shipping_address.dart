class ShippingAddress {
  final String recipient;
  final String phone;
  final String address;

  const ShippingAddress({
    required this.recipient,
    required this.phone,
    required this.address,
  });

  factory ShippingAddress.fromMap(Map<String, dynamic> map) {
    return ShippingAddress(
      recipient: map['recipient'] as String? ?? '-',
      phone: map['phone'] as String? ?? '-',
      address: map['address'] as String? ?? '-',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recipient': recipient,
      'phone': phone,
      'address': address,
    };
  }

  ShippingAddress copyWith({
    String? recipient,
    String? phone,
    String? address,
  }) {
    return ShippingAddress(
      recipient: recipient ?? this.recipient,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }
}
