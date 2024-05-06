import 'package:flutter/material.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';


class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.initialValue,
    required this.hintText,
    required this.label,
    this.prefixIcon,
    this.suffix,
    this.isObscureText = false,
    this.onChanged,
    this.validator,
  });
  final String? initialValue;
  final String hintText;
  final String label;
  final Icon? prefixIcon;
  final Widget? suffix;
  final bool isObscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyles.edgeInsetsL16R16B16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppStyles.edgeInsetsL8,
            child: Text(label),
          ),
          TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffix,
              border: _getBorder(),
              focusedBorder: _getBorder(),
            ),
            obscureText: isObscureText,
            onChanged: onChanged,
            validator: validator,
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _getBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.black),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
