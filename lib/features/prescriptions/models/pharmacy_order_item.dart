class PharmacyOrderItem {
  final String name;
  final String dosage;
  final String frequency;
  final int price;

  const PharmacyOrderItem({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.price,
  });

  factory PharmacyOrderItem.fromMap(Map<String, dynamic> map) {
    return PharmacyOrderItem(
      name: map['name'] as String? ?? '-',
      dosage: map['dosage'] as String? ?? '-',
      frequency: map['frequency'] as String? ?? '-',
      price: map['price'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'price': price,
    };
  }

  PharmacyOrderItem copyWith({
    String? name,
    String? dosage,
    String? frequency,
    int? price,
  }) {
    return PharmacyOrderItem(
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      price: price ?? this.price,
    );
  }
}
