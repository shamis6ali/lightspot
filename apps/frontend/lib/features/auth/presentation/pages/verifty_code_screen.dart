import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/di/injection_container.dart';
import '../cubits/verify_code/verify_code_cubit.dart';

class VerifyScreen extends StatefulWidget {
  final Function(String) onSendClicked;
  final Function onReSendClicked;
  final String phone;

  const VerifyScreen({
    super.key,
    required this.onSendClicked,
    required this.onReSendClicked,
    required this.phone,
  });

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    codeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerifyCodeCubit>(
      create: (context) => sl<VerifyCodeCubit>(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text(
                      'Verify Mobile Number',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 16),
                      const Text(
                        'Enter code sent to ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        widget.phone,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildCodeField(),
                  const SizedBox(height: 32),
                  _buildVerifyButton(),
                  const SizedBox(height: 16),
                  _buildResendButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCodeField() {
    return TextFormField(
      controller: codeController,
      decoration: const InputDecoration(
        labelText: 'Verification Code',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the verification code';
        }
        return null;
      },
    );
  }

  Widget _buildVerifyButton() {
    return BlocBuilder<VerifyCodeCubit, VerifyCodeState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state.requestState.isLoading
                ? null
                : () {
                    if (formKey.currentState!.validate()) {
                      widget.onSendClicked(codeController.text);
                    }
                  },
            child: state.requestState.isLoading
                ? const CircularProgressIndicator()
                : const Text('Verify'),
          ),
        );
      },
    );
  }

  Widget _buildResendButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          widget.onReSendClicked();
        },
        child: const Text('Resend Code'),
      ),
    );
  }
}
