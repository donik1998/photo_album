import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/presentation/custom_widgets/album_card.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

import '../../data/models/album_template.dart';

class TemplatesWidget extends StatelessWidget {
  final List<Album> dataList;
  final String title;
  final String type;

  const TemplatesWidget({
    Key? key,
    required this.dataList,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.ttxt1, textAlign: TextAlign.left),
            IconButton(onPressed: () {}, icon: SvgPicture.asset('assets/svgs/arrow_right.svg'))
          ],
        ),
        AppSpacing.verticalSpace24,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: dataList.map<Widget>((e) => AlbumCard(album: e)).toList(),
          ),
        ),
      ],
    );
  }
}
