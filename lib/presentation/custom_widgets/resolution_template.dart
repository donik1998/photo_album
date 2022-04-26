import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/presentation/state/main_page/main_page_body_state.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';
import 'package:photo_album/presentation/utils/routes.dart';
import 'package:provider/provider.dart';

class ResolutionTemplate extends StatelessWidget {
  final List<String> sizes;

  const ResolutionTemplate({
    Key? key,
    required this.sizes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: sizes
            .map<Widget>(
              (e) => GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.EDITOR_PAGE,
                  arguments: RedactorPageArgs(
                    albumPageTemplateCategories: context.read<MainPageBodyState>().templateCategories,
                    decorationCategories: context.read<MainPageBodyState>().decorationCategories,
                    albumBacks: context.read<MainPageBodyState>().albumBacks,
                    openElementsSheetFirst: true,
                  ),
                ),
                child: Container(
                  width: 110,
                  height: 110,
                  margin: EdgeInsets.only(right: 14),
                  decoration: BoxDecoration(
                    color: Color(0xFFC9C9C9),
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFE11577),
                        Color(0xFFFF5858),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/book.svg',
                        color: Colors.white,
                        width: 44,
                        height: 44,
                      ),
                      AppSpacing.verticalSpace7,
                      Text(
                        e,
                        style: AppTextStyles.txt13.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
