import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_dimensions.dart';

/// Card displaying the submitted text result
class SubmittedTextCard extends StatelessWidget {
  final String? text;

  const SubmittedTextCard({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.submittedTextTitle, style: AppTextStyles.cardTitle),
          const SizedBox(height: 12),
          Text(
            text ?? AppStrings.noTextSubmitted,
            style: text != null
                ? AppTextStyles.bodyLarge
                : AppTextStyles.bodyMedium.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
          ),
        ],
      ),
    );
  }
}
