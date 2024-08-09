import 'package:flutter/material.dart';

import '../../utils/text_style.dart';
import '../app_landing/dependecy_inject.dart';

class FitessLevelButton extends StatelessWidget {
  String title;
  VoidCallback onTap;
  String? iconText;
  bool? isSelected;
  FitessLevelButton({super.key,required this.title,required this.onTap,this.iconText,this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (state) {
            if (state.contains(WidgetState.pressed)) {
              return Colors.purpleAccent;
            }
            return isSelected == true ? Colors.purpleAccent :  Colors.black38;
          },
        ),
      ),
      onPressed: onTap,
      child: Row(
        children: [
          if(iconText != null)Image.asset(iconText!),
          Text(
            title,
            style: getIt<AppTextStyle>().mukta15pxnormal,
          ),
        ],
      ),
    );
  }
}
