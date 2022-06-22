import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/utils/data_provider.dart';

class FontsSheet extends StatelessWidget {
  const FontsSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 96 / 96,
        ),
        itemCount: fontFamilies.length,
        itemBuilder: (context, index) {
          final font = fontFamilies.elementAt(index);
          return GestureDetector(
            onTap: () {
              Navigator.pop(context, font.fontFamily);
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.black, width: 1),
              ),
              child: Center(
                child: Text(
                  font.fontName ?? '',
                  style: TextStyle(fontFamily: font.fontFamily, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
