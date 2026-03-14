import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:telemedicine_app/features/auth/providers/auth_provider.dart';
import 'package:telemedicine_app/shared/presentation/widgets/app_primary_button.dart';
import 'package:telemedicine_app/shared/presentation/widgets/app_text_field.dart';
import 'package:telemedicine_app/shared/presentation/widgets/auth_header.dart';
import 'package:telemedicine_app/shared/presentation/widgets/auth_scaffold.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    ref.read(authStateProvider.notifier).state = true;

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        children: [
          const SizedBox(height: 24),
          const AuthHeader(
            title: 'Masuk',
            subtitle: 'Masuk untuk melanjutkan layanan telemedicine.',
          ),
          const SizedBox(height: 32),
          AppTextField(
            label: 'Email',
            hintText: 'Masukkan email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
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
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text('Lupa password?'),
            ),
          ),
          const SizedBox(height: 16),
          AppPrimaryButton(
            text: 'Masuk',
            onPressed: _handleLogin,
            isLoading: _isLoading,
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Belum punya akun? ',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
              GestureDetector(
                onTap: () => context.push('/register'),
                child: const Text(
                  'Daftar',
                  style: TextStyle(
                    color: Color(0xFF2F80ED),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
