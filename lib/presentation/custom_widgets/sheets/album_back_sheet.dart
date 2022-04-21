import 'package:flutter/material.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';

class AlbumBackSheet extends StatelessWidget {
  final List<AlbumDecoration> backImages;
  final ValueChanged<AlbumDecoration> onSelected;

  const AlbumBackSheet({
    Key? key,
    required this.backImages,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        itemCount: backImages.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16),
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Image.network(
            backImages.elementAt(index).downloadLink,
            fit: BoxFit.cover,
            loadingBuilder: (context, url, progress) => Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
