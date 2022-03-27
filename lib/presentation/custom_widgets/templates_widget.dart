import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/data/models/pages_template_model.dart';
import 'package:photo_album/presentation/custom_widgets/element_card.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';
import 'package:photo_album/presentation/utils/routes.dart';

class TemplatesRowWidget extends StatelessWidget {
  final List<AlbumPageTemplate> templates;
  final String title;
  final String type;
  final bool showTopSpacing;
  final ValueChanged<AlbumPageTemplate> onTemplateChosen;

  const TemplatesRowWidget({
    Key? key,
    required this.templates,
    required this.showTopSpacing,
    required this.title,
    required this.type,
    required this.onTemplateChosen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showTopSpacing) AppSpacing.verticalSpace24,
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.ttxt1, textAlign: TextAlign.left),
            IconButton(
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoutes.ALL_TEMPLATES_PAGE,
                arguments: AllTemplatesPageArgs(templateType: type),
              ),
              icon: SvgPicture.asset('assets/svgs/arrow_right.svg'),
            )
          ],
        ),
        AppSpacing.verticalSpace24,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: templates
                .getRange(0, min<int>(4, templates.length))
                .map<Widget>(
                  (template) => ElementCard(
                    title: template.title,
                    imageLink: template.downloadLinks.first,
                    onTap: () => onTemplateChosen(template),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
