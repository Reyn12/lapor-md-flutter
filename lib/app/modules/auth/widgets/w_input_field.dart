import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final VoidCallback? onChanged;

  const CustomInputField({
    super.key,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.onChanged,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _isObscured = true;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            border: Border.all(
              color: _isFocused 
                  ? const Color(0xFF6C63FF) 
                  : Colors.grey[300]!,
              width: _isFocused ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            focusNode: _focusNode,
            obscureText: widget.isPassword ? _isObscured : false,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey[400]),
              prefixIcon: Icon(
                widget.prefixIcon,
                color: _isFocused 
                    ? const Color(0xFF6C63FF) 
                    : Colors.grey[600],
              ),
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: Icon(
                          _isObscured
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          key: ValueKey<bool>(_isObscured),
                          color: _isFocused 
                              ? const Color(0xFF6C63FF) 
                              : Colors.grey[600],
                        ),
                      ),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }
}

// Widget untuk email field khusus
class EmailInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const EmailInputField({
    super.key,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      label: 'Email Address',
      hintText: 'warga@manggadua.com',
      prefixIcon: Icons.email_outlined,
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.emailAddress,
    );
  }
}

// Widget untuk password field khusus
class PasswordInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;

  const PasswordInputField({
    super.key,
    this.controller,
    this.validator,
    this.hintText = 'Masukkan password kamu...',
  });

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      label: 'Password',
      hintText: hintText!,
      prefixIcon: Icons.lock_outline,
      isPassword: true,
      controller: controller,
      validator: validator,
    );
  }
} 