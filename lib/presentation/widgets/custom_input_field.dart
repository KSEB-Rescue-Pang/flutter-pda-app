import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final Widget? suffix;

  const CustomInputField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.isPassword = false,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: AppSizes.smallSpacing),
        SizedBox(
          width: AppSizes.inputFieldWidth,
          height: AppSizes.inputFieldHeight,
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
              ),
              filled: true,
              fillColor: AppColors.inputBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              suffixIcon: suffix,
            ),
          ),
        ),
      ],
    );
  }
}
