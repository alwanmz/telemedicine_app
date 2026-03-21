import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/presentation/widgets/app_primary_button.dart';
import '../../../../shared/presentation/widgets/app_text_field.dart';
import '../../models/user_address.dart';
import '../../providers/address_provider.dart';

class AddressFormPage extends ConsumerStatefulWidget {
  final UserAddress? address;

  const AddressFormPage({super.key, this.address});

  @override
  ConsumerState<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends ConsumerState<AddressFormPage> {
  late final TextEditingController _labelController;
  late final TextEditingController _recipientController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late bool _isDefault;

  bool get _isEditing => widget.address != null;

  @override
  void initState() {
    super.initState();
    final address = widget.address;
    _labelController = TextEditingController(text: address?.label ?? '');
    _recipientController = TextEditingController(
      text: address?.recipient ?? '',
    );
    _phoneController = TextEditingController(text: address?.phone ?? '');
    _addressController = TextEditingController(text: address?.address ?? '');
    _isDefault = address?.isDefault ?? false;
  }

  @override
  void dispose() {
    _labelController.dispose();
    _recipientController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Alamat' : 'Tambah Alamat'),
        centerTitle: false,
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: AppPrimaryButton(
            text: _isEditing ? 'Simpan Perubahan' : 'Simpan Alamat',
            onPressed: _saveAddress,
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
                  label: 'Label Alamat',
                  hintText: 'Contoh: Rumah, Kantor',
                  controller: _labelController,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Nama Penerima',
                  hintText: 'Masukkan nama penerima',
                  controller: _recipientController,
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
                  label: 'Alamat Lengkap',
                  hintText: 'Masukkan alamat lengkap',
                  controller: _addressController,
                ),
                const SizedBox(height: 18),
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    setState(() {
                      _isDefault = !_isDefault;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _isDefault
                              ? Icons.check_circle_rounded
                              : Icons.radio_button_unchecked_rounded,
                          color: _isDefault
                              ? const Color(0xFF2F80ED)
                              : const Color(0xFF9CA3AF),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Jadikan sebagai alamat utama',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _saveAddress() {
    final label = _labelController.text.trim();
    final recipient = _recipientController.text.trim();
    final phone = _phoneController.text.trim();
    final addressText = _addressController.text.trim();

    if (label.isEmpty ||
        recipient.isEmpty ||
        phone.isEmpty ||
        addressText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua field alamat harus diisi'),
        ),
      );
      return;
    }

    final address = UserAddress(
      id: widget.address?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      label: label,
      recipient: recipient,
      phone: phone,
      address: addressText,
      isDefault: _isDefault,
    );

    final notifier = ref.read(addressProvider.notifier);
    if (_isEditing) {
      notifier.updateAddress(address);
    } else {
      notifier.addAddress(address);
    }

    Navigator.of(context).pop();
  }
}
