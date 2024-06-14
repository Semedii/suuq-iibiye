import 'package:flutter/material.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.prefixWidget,
    this.isLoading = false,
    this.isSmall = false,
    this.isTransparent = false,
    this.noTopMargin = false,
  });
  final String title;
  final Widget? prefixWidget;
  final bool isLoading;
  final bool isSmall;
  final bool isTransparent;
  final bool noTopMargin;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: isSmall? phoneWidth*.4: phoneWidth*.8,
        margin: noTopMargin? const EdgeInsets.symmetric(horizontal: 32) : AppStyles.edgeInsetsT20L32R32,
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
      border: Border.all(color: isTransparent? AppColors.black: Colors.transparent),
      color: isTransparent? Colors.transparent:AppColors.green,
    );
  }

  Row _getTitleText() {
    return Row(
      children: [
        prefixWidget!=null? prefixWidget!: const SizedBox.shrink(),
        Expanded(
          child: Center(
            child: Text(
              title.toUpperCase(),
              style:  TextStyle(
                color: isTransparent? AppColors.black : AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
