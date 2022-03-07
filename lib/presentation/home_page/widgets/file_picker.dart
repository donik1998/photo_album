import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';

class FilePickerWidget extends StatefulWidget {
  final ValueChanged<List<PlatformFile>> onFileSelected;
  final double? height;
  final double? width;
  final Widget initialWidget;
  final bool allowMultipleChoice;

  const FilePickerWidget({
    Key? key,
    required this.onFileSelected,
    this.allowMultipleChoice = false,
    required this.initialWidget,
    this.width = double.infinity,
    this.height,
  }) : super(key: key);

  @override
  State<FilePickerWidget> createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  PlatformFile? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.darkBlue,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () async {
          final pickedFiles = await FilePicker.platform.pickFiles(allowMultiple: widget.allowMultipleChoice);
          if (pickedFiles?.files.isNotEmpty ?? false) {
            setState(() => _selectedFile = pickedFiles!.files.first);
            widget.onFileSelected(pickedFiles!.files);
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          width: widget.width,
          height: widget.height ?? 343,
          decoration: BoxDecoration(
            color: AppColors.darkBlue,
            border: Border.all(width: 1.0, color: AppColors.grey),
            borderRadius: BorderRadius.circular(16),
          ),
          child: _selectedFile == null
              ? widget.initialWidget
              : Image.memory(_selectedFile?.bytes ?? Uint8List(10), fit: BoxFit.fitHeight),
        ),
      ),
    );
  }
}
