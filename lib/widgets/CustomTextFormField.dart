import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_gallery/resources/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String iconPath;

  const CustomTextFormField({required this.hintText, required this.iconPath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      child: TextFormField(
        cursorColor: AppColors.pink,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(iconPath),
          ),
          hintStyle: TextStyle(fontSize: 17),
          hintText: hintText,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.only(top: 6, left: 10),
          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.pink)),
        ),
      ),
    );
  }
}
