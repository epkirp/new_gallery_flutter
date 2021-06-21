import 'package:flutter/material.dart';
import 'package:new_gallery/resources/app_colors.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(15),
            width: 85,
            height: 85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.gray),
            ),
          ),
        ),
      ],
    );
  }
}
