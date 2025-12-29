import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_dimensions.dart';

/// Text input field with custom styling
class TextInputCard extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onSubmit;

  const TextInputCard({super.key, required this.controller, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: AppTextStyles.inputText,
        decoration: InputDecoration(
          hintText: AppStrings.inputHint,
          hintStyle: AppTextStyles.inputHint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
            borderSide: const BorderSide(
              color: AppColors.borderFocused,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: AppColors.surface,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        onSubmitted: (_) => onSubmit?.call(),
      ),
    );
  }
}
