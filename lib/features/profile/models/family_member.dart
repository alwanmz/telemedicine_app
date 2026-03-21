class FamilyMember {
  static const String genderMale = 'male';
  static const String genderFemale = 'female';

  final String id;
  final String fullName;
  final String relationship;
  final String birthDate;
  final String gender;

  const FamilyMember({
    required this.id,
    required this.fullName,
    required this.relationship,
    required this.birthDate,
    required this.gender,
  });

  factory FamilyMember.fromMap(Map<String, dynamic> map) {
    return FamilyMember(
      id: map['id'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '-',
      relationship: map['relationship'] as String? ?? '-',
      birthDate: map['birthDate'] as String? ?? '-',
      gender: normalizeGender(map['gender'] as String?),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'relationship': relationship,
      'birthDate': birthDate,
      'gender': gender,
    };
  }

  FamilyMember copyWith({
    String? id,
    String? fullName,
    String? relationship,
    String? birthDate,
    String? gender,
  }) {
    return FamilyMember(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      relationship: relationship ?? this.relationship,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
    );
  }

  String get genderLabel => labelForGender(gender);

  static String normalizeGender(String? rawGender) {
    if (rawGender == genderFemale || rawGender == 'Perempuan') {
      return genderFemale;
    }
    return genderMale;
  }

  static String labelForGender(String gender) {
    if (gender == genderFemale) {
      return 'Perempuan';
    }
    return 'Laki-laki';
  }
}
