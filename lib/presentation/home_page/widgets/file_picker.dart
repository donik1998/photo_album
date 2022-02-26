import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class FilePickerWidget extends StatefulWidget {
  final ValueChanged<List<PlatformFile>> onFileSelected;
  final String? initialFileLink;
  final double? height;

  const FilePickerWidget({
    Key? key,
    required this.onFileSelected,
    this.initialFileLink,
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
          final pickedFiles = await FilePicker.platform.pickFiles();
          if (pickedFiles?.files.isNotEmpty ?? false) {
            setState(() => _selectedFile = pickedFiles!.files.first);
            widget.onFileSelected(pickedFiles!.files);
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          width: double.infinity,
          height: widget.height ?? 343,
          decoration: BoxDecoration(
            color: AppColors.darkBlue,
            border: Border.all(width: 1.0, color: AppColors.grey),
            borderRadius: BorderRadius.circular(16),
          ),
          child: (widget.initialFileLink?.isNotEmpty ?? false) && _selectedFile == null
              ? CachedNetworkImage(imageUrl: widget.initialFileLink ?? '')
              : Image.memory(
                  _selectedFile?.bytes ?? Uint8List(10),
                  fit: BoxFit.fitHeight,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Text(
                      'Нажмите здесь чтобы выбрать файл',
                      style: AppTextStyles.title.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}