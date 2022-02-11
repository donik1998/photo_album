import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/data/models/album_template.dart';
import 'package:photo_album/presentation/custom_widgets/custom_textfield.dart';
import 'package:photo_album/presentation/custom_widgets/resolution_template.dart';
import 'package:photo_album/presentation/custom_widgets/templates_widget.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_cubit.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_state.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class MainPageBody extends StatefulWidget {
  const MainPageBody({Key? key}) : super(key: key);

  @override
  State<MainPageBody> createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody> {
  List<Album> art = List.generate(
    6,
    (index) => Album(
      type: 'Бесплатный',
      title: 'free',
      thumbnailLink: 'assets/templatesImages/art${++index}.jpeg',
      widthCm: 110,
      heightCm: 110,
      widthInch: 10,
      heightInch: 10,
    ),
  );
  List<Album> love = List.generate(
    6,
    (index) => Album(
      type: 'Бесплатный',
      title: 'free',
      thumbnailLink: 'assets/templatesImages/l${++index}.jpeg',
      widthCm: 110,
      heightCm: 110,
      widthInch: 10,
      heightInch: 10,
    ),
  );
  List<Album> travel = List.generate(
    6,
    (index) => Album(
      type: 'Бесплатный',
      title: 'free',
      thumbnailLink: 'assets/templatesImages/t${++index}.jpeg',
      widthCm: 110,
      heightCm: 110,
      widthInch: 10,
      heightInch: 10,
    ),
  );
  TextEditingController _textController = TextEditingController();
  bool _searchBarEnabled = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: AppInsets.horizontalInsets16,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.verticalSpace4,
              CustomTextField(
                onTap: () => setState(() => _searchBarEnabled = !_searchBarEnabled),
                controller: _textController,
                enabled: _searchBarEnabled,
              ),
              AppSpacing.verticalSpace16,
              Stack(
                children: [
                  Container(
                    width: 358,
                    height: 156,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/Rectangle 386.png')),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    top: 16,
                    child: Text(
                      'Создавайте альбомы\nсо своими истроиями',
                      style: AppTextStyles.ttxt,
                    ),
                  ),
                ],
              ),
              AppSpacing.verticalSpace32,
              Text('Создайте свой альбом', style: AppTextStyles.ttxt1),
              AppSpacing.verticalSpace24,
              ResolutionTemplate(sizes: ['20x20', '23x23', '25x25']),
              AppSpacing.verticalSpace24,
              TemplatesWidget(dataList: travel, title: 'Путешествие', type: 'Бесплатный'),
              AppSpacing.verticalSpace24,
              TemplatesWidget(dataList: love, title: 'Любовь', type: 'Бесплатный'),
              AppSpacing.verticalSpace24,
              TemplatesWidget(dataList: art, title: 'Искусство', type: 'Бесплатный'),
              AppSpacing.verticalSpace24,
            ],
          ),
        );
      },
    );
  }
}
