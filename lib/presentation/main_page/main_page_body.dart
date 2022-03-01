import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/data/models/album_page_template_category.dart';
import 'package:photo_album/data/models/pages_template_model.dart';
import 'package:photo_album/presentation/custom_widgets/custom_textfield.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
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
  List<AlbumPageTemplateCategory> templatePageCategories = List.empty(growable: true);
  TextEditingController _textController = TextEditingController();
  bool _searchBarEnabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final categoriesDocs = await FirebaseFirestore.instance.collection('album_template_page_types').get();
      setState(() {
        templatePageCategories = List.from(
          categoriesDocs.docs.map((e) => AlbumPageTemplateCategory.fromJson(e.data())),
        );
      });
    });
  }

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
              for (final templateCategory in templatePageCategories)
                FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('album_page_templates')
                      .where(
                        'type',
                        isEqualTo: templateCategory.value,
                      )
                      .get(),
                  builder: (context, templatesSnapshot) {
                    if (templatesSnapshot.connectionState == ConnectionState.waiting)
                      return Loader();
                    else
                      return TemplatesRowWidget(
                        templates: templatesSnapshot.data!.docs.map((e) => AlbumPageTemplate.fromJson(e.data())).toList(),
                        showTopSpacing: true,
                        title: templateCategory.masks['ru'],
                        type: templateCategory.value,
                      );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
