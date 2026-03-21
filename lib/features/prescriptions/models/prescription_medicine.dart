class PrescriptionMedicine {
  final String name;
  final String dosage;
  final String frequency;

  const PrescriptionMedicine({
    required this.name,
    required this.dosage,
    required this.frequency,
  });

  factory PrescriptionMedicine.fromMap(Map<String, dynamic> map) {
    return PrescriptionMedicine(
      name: map['name'] as String? ?? '-',
      dosage: map['dosage'] as String? ?? '-',
      frequency: map['frequency'] as String? ?? '-',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
    };
  }

  PrescriptionMedicine copyWith({
    String? name,
    String? dosage,
    String? frequency,
  }) {
    return PrescriptionMedicine(
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
    );
  }
}
