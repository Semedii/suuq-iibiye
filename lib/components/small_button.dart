import 'package:flutter/material.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    required this.title,
    required this.onPressed,
    this.isTransparent = false,
    super.key,
  });

  final String title;
  final void Function()? onPressed;
  final bool isTransparent;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: isTransparent ? AppColors.white : AppColors.green,
          side: BorderSide(
            color: isTransparent ? AppColors.black : Colors.transparent,
          )),
      child: Text(
        title,
        style: TextStyle(
          color: isTransparent ? AppColors.black : AppColors.white,
        ),
      ),
    );
  }
}
