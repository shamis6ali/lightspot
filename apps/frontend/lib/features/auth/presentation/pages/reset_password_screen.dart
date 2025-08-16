import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/di/injection_container.dart';
import '../cubits/setNewPassword/set_new_password_cubit.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.token});

  final String token;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SetNewPasswordCubit>(
      create: (context) => sl<SetNewPasswordCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reset Password'),
        ),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Image(
                      image: AssetImage('assets/pins/location-pin.png'), // TODO: Update with actual logo
                      height: 180,
                      alignment: Alignment.center,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'New Password',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Enter your new password',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildPasswordField(),
                  const SizedBox(height: 16),
                  _buildConfirmPasswordField(),
                  const SizedBox(height: 24),
                  _buildResetButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'New Password',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your new password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Confirm New Password',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your new password';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  Widget _buildResetButton() {
    return BlocBuilder<SetNewPasswordCubit, SetNewPasswordState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state.requestState.isLoading
                ? null
                : () {
                    if (formKey.currentState!.validate()) {
                      context.read<SetNewPasswordCubit>().resetPassword(
                            token: widget.token,
                            password: _passwordController.text,
                            confirmPassword: _confirmPasswordController.text,
                          );
                    }
                  },
            child: state.requestState.isLoading
                ? const CircularProgressIndicator()
                : const Text('Reset Password'),
          ),
        );
      },
    );
  }
}
