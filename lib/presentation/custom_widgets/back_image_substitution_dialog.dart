import 'package:flutter/material.dart';

class BackImageSubstitutionConfirmationDialog extends StatelessWidget {
  final VoidCallback onCancel, onConfirm;

  const BackImageSubstitutionConfirmationDialog({
    Key? key,
    required this.onCancel,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('Похоже что у вас уже есть фоновая картинка. Хотите ее заменить?'),
      actions: [
        TextButton(
          onPressed: () {
            onCancel();
            Navigator.pop(context);
          },
          child: Text('Нет, создать отдельную страницу'),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: Text('Да, заменить фон'),
        ),
      ],
    );
  }
}
