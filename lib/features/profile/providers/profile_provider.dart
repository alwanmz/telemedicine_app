import 'package:flutter_riverpod/legacy.dart';

import '../models/user_profile.dart';

final profileProvider =
    StateNotifierProvider<ProfileNotifier, UserProfile>(
      (ref) => ProfileNotifier(),
    );

class ProfileNotifier extends StateNotifier<UserProfile> {
  ProfileNotifier() : super(_dummyProfile);

  void updateProfile(UserProfile profile) {
    state = profile;
  }
}

const UserProfile _dummyProfile = UserProfile(
  fullName: 'Alwan Maulana',
  email: 'alwan@example.com',
  phoneNumber: '0812-3456-7890',
  birthDate: '12 Maret 1998',
  gender: UserProfile.genderMale,
  photoVariant: UserProfile.photoVariantBlue,
);
