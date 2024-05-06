import 'package:flutter/material.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
  });
  final String title;
  final bool isLoading;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: 350,
        margin: AppStyles.edgeInsetsT20L32R32,
        padding: AppStyles.edgeInsetsV10H20,
        decoration: _getDecoration(),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColors.white,
              ))
            : _getTitleText(),
      ),
    );
  }

  BoxDecoration _getDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: AppColors.darkGrey,
    );
  }

  Center _getTitleText() {
    return Center(
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
