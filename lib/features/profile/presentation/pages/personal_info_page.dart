import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/presentation/widgets/app_primary_button.dart';
import '../../../../shared/presentation/widgets/app_text_field.dart';
import '../../models/user_profile.dart';
import '../../providers/profile_provider.dart';

class PersonalInfoPage extends ConsumerStatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  ConsumerState<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends ConsumerState<PersonalInfoPage> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _birthDateController;
  late String _selectedGender;
  late String _selectedPhotoVariant;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider);
    _fullNameController = TextEditingController(text: profile.fullName);
    _emailController = TextEditingController(text: profile.email);
    _phoneController = TextEditingController(text: profile.phoneNumber);
    _birthDateController = TextEditingController(text: profile.birthDate);
    _selectedGender = profile.gender;
    _selectedPhotoVariant = profile.photoVariant;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Pribadi'), centerTitle: false),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: AppPrimaryButton(
            text: 'Simpan Perubahan',
            onPressed: _saveProfile,
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
                _ProfileAvatar(variant: _selectedPhotoVariant, radius: 36),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    _showPhotoOptions();
                  },
                  child: const Text('Ubah Foto Profil'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
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
                  hintText: 'Masukkan nama lengkap',
                  controller: _fullNameController,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Email',
                  hintText: 'Masukkan email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Nomor Telepon',
                  hintText: 'Masukkan nomor telepon',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Tanggal Lahir',
                  hintText: 'Contoh: 12 Maret 1998',
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
                      value: UserProfile.genderMale,
                      selectedValue: _selectedGender,
                      onSelected: _selectGender,
                    ),
                    _GenderChip(
                      label: 'Perempuan',
                      value: UserProfile.genderFemale,
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

  Future<void> _showPhotoOptions() async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        final options = [
          UserProfile.photoVariantBlue,
          UserProfile.photoVariantGreen,
          UserProfile.photoVariantOrange,
        ];

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pilih Foto Profil',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: options.map((option) {
                    final isSelected = option == _selectedPhotoVariant;

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            setState(() {
                              _selectedPhotoVariant = option;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFEAF4FF)
                                  : const Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF2F80ED)
                                    : const Color(0xFFE5E7EB),
                              ),
                            ),
                            child: Column(
                              children: [
                                _ProfileAvatar(variant: option, radius: 24),
                                const SizedBox(height: 10),
                                Text(
                                  _labelForPhotoVariant(option),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF374151),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveProfile() {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final birthDate = _birthDateController.text.trim();

    if (fullName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        birthDate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua data pribadi harus diisi'),
        ),
      );
      return;
    }

    ref
        .read(profileProvider.notifier)
        .updateProfile(
          UserProfile(
            fullName: fullName,
            email: email,
            phoneNumber: phone,
            birthDate: birthDate,
            gender: _selectedGender,
            photoVariant: _selectedPhotoVariant,
          ),
        );

    Navigator.of(context).pop();
  }

  String _labelForPhotoVariant(String variant) {
    if (variant == UserProfile.photoVariantGreen) {
      return 'Hijau';
    }
    if (variant == UserProfile.photoVariantOrange) {
      return 'Oranye';
    }
    return 'Biru';
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

class _ProfileAvatar extends StatelessWidget {
  final String variant;
  final double radius;

  const _ProfileAvatar({required this.variant, required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: _backgroundColorForVariant(variant),
      child: Icon(
        _iconForVariant(variant),
        size: radius,
        color: Colors.white,
      ),
    );
  }

  static Color _backgroundColorForVariant(String variant) {
    if (variant == UserProfile.photoVariantGreen) {
      return const Color(0xFF20B486);
    }
    if (variant == UserProfile.photoVariantOrange) {
      return const Color(0xFFEA580C);
    }
    return const Color(0xFF2F80ED);
  }

  static IconData _iconForVariant(String variant) {
    if (variant == UserProfile.photoVariantGreen) {
      return Icons.face_rounded;
    }
    if (variant == UserProfile.photoVariantOrange) {
      return Icons.sentiment_very_satisfied_rounded;
    }
    return Icons.person_rounded;
  }
}
