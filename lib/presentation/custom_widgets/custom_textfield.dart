import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final VoidCallback onTap;
  final TextEditingController controller;
  final bool enabled;

  const CustomTextField({
    Key? key,
    required this.onTap,
    required this.controller,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      enabled: enabled,
      controller: controller,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        focusColor: Colors.grey,
        prefixIcon: Icon(
          Icons.search,
          color: Color(0xFF2E2E2E),
        ),
        fillColor: Theme.of(context).disabledColor,
        border: InputBorder.none,
        hintText: 'Поиск',
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
      onEditingComplete: () {},
    );
  }
}
