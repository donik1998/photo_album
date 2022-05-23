import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final VoidCallback onTap;
  final TextEditingController controller;
  final bool enabled;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? autofocus;

  const CustomTextField({
    Key? key,
    required this.onTap,
    this.hintText,
    this.autofocus,
    required this.onChanged,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TextField(
        onTap: onTap,
        autofocus: autofocus ?? false,
        enabled: enabled,
        onChanged: onChanged,
        controller: controller,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          focusColor: Colors.grey,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.zero,
          fillColor: Theme.of(context).disabledColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.pinkLight, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.pinkLight, width: 1.0),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
        ),
        onEditingComplete: () {},
      ),
    );
  }
}
