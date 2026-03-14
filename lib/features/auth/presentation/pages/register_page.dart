import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telemedicine_app/shared/presentation/widgets/app_primary_button.dart';
import 'package:telemedicine_app/shared/presentation/widgets/app_text_field.dart';
import 'package:telemedicine_app/shared/presentation/widgets/auth_header.dart';
import 'package:telemedicine_app/shared/presentation/widgets/auth_scaffold.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registrasi berhasil. Silakan masuk.')),
    );

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      appBar: AppBar(title: const Text('Daftar'), centerTitle: false),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        children: [
          const AuthHeader(
            title: 'Buat akun baru',
            subtitle: 'Lengkapi data berikut untuk mulai menggunakan layanan.',
            showLogo: false,
          ),
          const SizedBox(height: 28),
          AppTextField(
            label: 'Nama Lengkap',
            hintText: 'Masukkan nama lengkap',
            controller: _nameController,
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: 'Email',
            hintText: 'Masukkan email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: 'No. HP',
            hintText: 'Masukkan nomor HP',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: 'Password',
            hintText: 'Masukkan password',
            controller: _passwordController,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
          ),
          const SizedBox(height: 28),
          AppPrimaryButton(
            text: 'Daftar',
            onPressed: _handleRegister,
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }
}
