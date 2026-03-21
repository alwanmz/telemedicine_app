class UserProfile {
  static const String genderMale = 'male';
  static const String genderFemale = 'female';

  static const String photoVariantBlue = 'blue';
  static const String photoVariantGreen = 'green';
  static const String photoVariantOrange = 'orange';

  final String fullName;
  final String email;
  final String phoneNumber;
  final String birthDate;
  final String gender;
  final String photoVariant;

  const UserProfile({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.birthDate,
    required this.gender,
    required this.photoVariant,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      fullName: map['fullName'] as String? ?? '-',
      email: map['email'] as String? ?? '-',
      phoneNumber: map['phoneNumber'] as String? ?? '-',
      birthDate: map['birthDate'] as String? ?? '-',
      gender: normalizeGender(map['gender'] as String?),
      photoVariant: normalizePhotoVariant(map['photoVariant'] as String?),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate,
      'gender': gender,
      'photoVariant': photoVariant,
    };
  }

  UserProfile copyWith({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? birthDate,
    String? gender,
    String? photoVariant,
  }) {
    return UserProfile(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      photoVariant: photoVariant ?? this.photoVariant,
    );
  }

  String get genderLabel => labelForGender(gender);

  static String normalizeGender(String? rawGender) {
    if (rawGender == genderFemale || rawGender == 'Perempuan') {
      return genderFemale;
    }
    return genderMale;
  }

  static String normalizePhotoVariant(String? rawVariant) {
    if (rawVariant == photoVariantGreen) {
      return photoVariantGreen;
    }
    if (rawVariant == photoVariantOrange) {
      return photoVariantOrange;
    }
    return photoVariantBlue;
  }

  static String labelForGender(String gender) {
    if (gender == genderFemale) {
      return 'Perempuan';
    }
    return 'Laki-laki';
  }
}
