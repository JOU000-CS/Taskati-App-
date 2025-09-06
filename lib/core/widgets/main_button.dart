import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';


class MainButton extends StatelessWidget {
  const MainButton({
    super.key, required this.text, required this.onPressed, this.width = double.infinity, this.height = 55, this.margin = EdgeInsets.zero ,
  });

  final String text;
  final Function() onPressed;
  final double width;
  final double height;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
