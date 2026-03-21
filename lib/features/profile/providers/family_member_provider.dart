import 'package:flutter_riverpod/legacy.dart';

import '../models/family_member.dart';

final familyMemberProvider =
    StateNotifierProvider<FamilyMemberNotifier, List<FamilyMember>>(
      (ref) => FamilyMemberNotifier(),
    );

class FamilyMemberNotifier extends StateNotifier<List<FamilyMember>> {
  FamilyMemberNotifier() : super(_dummyFamilyMembers);

  void addMember(FamilyMember member) {
    state = [member, ...state];
  }

  void updateMember(FamilyMember member) {
    state = state.map((item) {
      if (item.id != member.id) {
        return item;
      }

      return member;
    }).toList();
  }
}

final List<FamilyMember> _dummyFamilyMembers = [
  const FamilyMember(
    id: 'fam_1',
    fullName: 'Nadya Aulia',
    relationship: 'Istri',
    birthDate: '5 Juni 1999',
    gender: FamilyMember.genderFemale,
  ),
  const FamilyMember(
    id: 'fam_2',
    fullName: 'Rafi Maulana',
    relationship: 'Anak',
    birthDate: '20 Januari 2021',
    gender: FamilyMember.genderMale,
  ),
];
