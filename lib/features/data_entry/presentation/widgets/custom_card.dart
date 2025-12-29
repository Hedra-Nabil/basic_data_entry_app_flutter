import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

/// Custom card widget with consistent styling
class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;

  const CustomCard({super.key, required this.child, this.padding, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding:
          padding ??
          const EdgeInsets.symmetric(
            horizontal: AppDimensions.cardPaddingHorizontal,
            vertical: AppDimensions.cardPaddingVertical,
          ),
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
      child: child,
    );
  }
}
