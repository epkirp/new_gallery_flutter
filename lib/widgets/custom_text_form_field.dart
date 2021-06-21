import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_gallery/resources/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final String iconPath;
  final Function(String) onChanged;

  const CustomTextFormField({
    required this.hintText,
    required this.errorText,
    required this.iconPath,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (text) {
        onChanged(text);
      },
      cursorColor: AppColors.pink,
      decoration: InputDecoration(
        isCollapsed: true,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(iconPath),
        ),
        hintStyle: TextStyle(fontSize: 17),
        hintText: hintText,
        errorText: errorText,
        errorStyle: TextStyle(fontSize: 12, color: AppColors.red),
        border: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.gray)),
        contentPadding: EdgeInsets.only(top: 15, left: 10),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.pink)),
      ),
    );
  }
}
