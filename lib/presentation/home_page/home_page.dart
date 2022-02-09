import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_cubit.dart';
import 'package:photo_album/presentation/home_page/bloc/home_page_state.dart';
import 'package:photo_album/presentation/theme/app_spacing.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textController = TextEditingController();
  bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: BlocConsumer<HomePageCubit, HomePageState>(
          listener: (context, state) {},
          builder: (context, state) {
            return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppSpacing.verticalSpace4,
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFFF3F3F3),
                      ),
                      width: 358,
                      height: 36,
                      child: TextField(
                        onTap: () {
                          setState(() {
                            enabled = !enabled!;
                          });
                        },
                        enabled: enabled,
                        controller: _textController,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          focusColor: Colors.grey,
                          hoverColor: Colors.grey,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF2E2E2E),
                          ),
                          fillColor: Theme.of(context).disabledColor,
                          border: InputBorder.none,
                          hintText: 'Поиск',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        onEditingComplete: () {},
                      ),
                    ),
                    AppSpacing.verticalSpace16,
                    Stack(
                      children: [
                        Container(
                          width: 358,
                          height: 156,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/Rectangle 386.png'))),
                        ),
                        Positioned(
                            left: 16,
                            top: 16,
                            right: 131,
                            bottom: 76,
                            child: Text(
                              'Создавайте альбомы\nсо своими истроиями',
                              style: AppTextStyles.ttxt,
                            )),
                      ],
                    ),
                    AppSpacing.verticalSpace32,
                    Text(
                      'Создайте свой альбом',
                      style: AppTextStyles.ttxt1,
                    ),
                  ],
                ));
          },
        ),
      )),
    );
  }
}
