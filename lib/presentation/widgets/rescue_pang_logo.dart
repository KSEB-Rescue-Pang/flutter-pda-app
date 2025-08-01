import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class RescuePangLogo extends StatelessWidget {
  const RescuePangLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [AppColors.logoGradientStart, AppColors.logoGradientEnd],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(bounds),
      child: const Text(
        'RescuePang',
        style: TextStyle(
          color: AppColors.textWhite,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          fontFamily: 'Inter',
          letterSpacing: 0,
        ),
      ),
    );
  }
}
