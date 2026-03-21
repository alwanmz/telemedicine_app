import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/presentation/widgets/app_primary_button.dart';
import '../../../../shared/presentation/widgets/app_text_field.dart';
import '../../models/family_member.dart';
import '../../providers/family_member_provider.dart';

class FamilyMemberFormPage extends ConsumerStatefulWidget {
  final FamilyMember? member;

  const FamilyMemberFormPage({super.key, this.member});

  @override
  ConsumerState<FamilyMemberFormPage> createState() =>
      _FamilyMemberFormPageState();
}

class _FamilyMemberFormPageState extends ConsumerState<FamilyMemberFormPage> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _relationshipController;
  late final TextEditingController _birthDateController;
  late String _selectedGender;

  bool get _isEditing => widget.member != null;

  @override
  void initState() {
    super.initState();
    final member = widget.member;
    _fullNameController = TextEditingController(text: member?.fullName ?? '');
    _relationshipController = TextEditingController(
      text: member?.relationship ?? '',
    );
    _birthDateController = TextEditingController(
      text: member?.birthDate ?? '',
    );
    _selectedGender = member?.gender ?? FamilyMember.genderMale;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _relationshipController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Edit Anggota Keluarga' : 'Tambah Anggota Keluarga',
        ),
        centerTitle: false,
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: AppPrimaryButton(
            text: _isEditing ? 'Simpan Perubahan' : 'Simpan Anggota',
            onPressed: _saveMember,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Column(
              children: [
                AppTextField(
                  label: 'Nama Lengkap',
                  hintText: 'Masukkan nama anggota keluarga',
                  controller: _fullNameController,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Hubungan Keluarga',
                  hintText: 'Contoh: Ayah, Ibu, Anak, Pasangan',
                  controller: _relationshipController,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Tanggal Lahir',
                  hintText: 'Contoh: 20 Januari 2021',
                  controller: _birthDateController,
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: 18),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Jenis Kelamin',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _GenderChip(
                      label: 'Laki-laki',
                      value: FamilyMember.genderMale,
                      selectedValue: _selectedGender,
                      onSelected: _selectGender,
                    ),
                    _GenderChip(
                      label: 'Perempuan',
                      value: FamilyMember.genderFemale,
                      selectedValue: _selectedGender,
                      onSelected: _selectGender,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _selectGender(String value) {
    setState(() {
      _selectedGender = value;
    });
  }

  void _saveMember() {
    final fullName = _fullNameController.text.trim();
    final relationship = _relationshipController.text.trim();
    final birthDate = _birthDateController.text.trim();

    if (fullName.isEmpty || relationship.isEmpty || birthDate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua data anggota keluarga harus diisi'),
        ),
      );
      return;
    }

    final member = FamilyMember(
      id: widget.member?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: fullName,
      relationship: relationship,
      birthDate: birthDate,
      gender: _selectedGender,
    );

    final notifier = ref.read(familyMemberProvider.notifier);
    if (_isEditing) {
      notifier.updateMember(member);
    } else {
      notifier.addMember(member);
    }

    Navigator.of(context).pop();
  }
}

class _GenderChip extends StatelessWidget {
  final String label;
  final String value;
  final String selectedValue;
  final ValueChanged<String> onSelected;

  const _GenderChip({
    required this.label,
    required this.value,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == selectedValue;

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: () {
        onSelected(value);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2F80ED) : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2F80ED)
                : const Color(0xFFE5E7EB),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF374151),
          ),
        ),
      ),
    );
  }
}
