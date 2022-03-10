import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/data/models/pages_template_model.dart';
import 'package:photo_album/presentation/custom_widgets/element_card.dart';
import 'package:photo_album/presentation/state/main_page/main_page_body_state.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';
import 'package:photo_album/presentation/utils/routes.dart';
import 'package:provider/provider.dart';

class TemplatesRowWidget extends StatelessWidget {
  final List<AlbumPageTemplate> templates;
  final String title;
  final String type;
  final bool showTopSpacing;

  const TemplatesRowWidget({
    Key? key,
    required this.templates,
    required this.showTopSpacing,
    required this.title,
    required this.type,
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
                arguments: AllTemplatesPageArgs(templates: templates),
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
            children: templates
                .getRange(0, min<int>(4, templates.length))
                .map<Widget>(
                  (template) => ElementCard(
                    title: template.title,
                    imageLink: template.downloadLinks.first,
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.EDITOR_PAGE,
                      arguments: RedactorPageArgs(
                        decorationCategories: context.read<MainPageBodyState>().decorationCategories,
                        albumPageTemplateCategories: context.read<MainPageBodyState>().templateCategories,
                        backImage: CachedNetworkImage(
                          imageUrl: template.downloadLinks.first,
                          progressIndicatorBuilder: (context, child, progress) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
