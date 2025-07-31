import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/di/injection_container.dart';
import '../cubits/signup/signup_cubit.dart';
import '../cubits/login_info/login_info_cubit.dart';
import '../cubits/login/login_cubit.dart';
import '../../data/models/params/register_params.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool confirmPolicy = false;

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignupCubit>(
          create: (context) => sl<SignupCubit>(),
        ),
        BlocProvider<LoginInfoCubit>(
          create: (context) => sl<LoginInfoCubit>(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => sl<LoginCubit>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Account'),
        ),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Center(
                    child: Image(
                      image: AssetImage('assets/pins/location-pin.png'), // TODO: Update with actual logo
                      height: 190,
                      alignment: Alignment.center,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Create New Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildPhoneField(),
                  const SizedBox(height: 16),
                  _buildPasswordField(),
                  const SizedBox(height: 16),
                  _buildConfirmPasswordField(),
                  const SizedBox(height: 16),
                  _buildPolicyCheckbox(),
                  const SizedBox(height: 24),
                  _buildSignupButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      decoration: const InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
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
        labelText: 'Confirm Password',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  Widget _buildPolicyCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: confirmPolicy,
          onChanged: (value) {
            setState(() {
              confirmPolicy = value ?? false;
            });
          },
        ),
        const Expanded(
          child: Text(
            'I agree to the Terms and Conditions',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildSignupButton() {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (!confirmPolicy || state.requestState.isLoading)
                ? null
                : () {
                    if (formKey.currentState!.validate()) {
                      final params = RegisterParams(
                        _confirmPasswordController.text,
                        phone: _phoneController.text,
                        password: _passwordController.text,
                      );
                      context.read<SignupCubit>().signup(params: params);
                    }
                  },
            child: state.requestState.isLoading
                ? const CircularProgressIndicator()
                : const Text('Sign Up'),
          ),
        );
      },
    );
  }
}
