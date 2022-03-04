import 'package:flutter/material.dart';
import 'package:photo_album/presentation/editor_page/widgets/elements_sheet.dart';
import 'package:photo_album/presentation/theme/app_colors.dart';
import 'package:photo_album/presentation/theme/different_icons.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class RedactorPage extends StatefulWidget {
  final Widget? backImage;

  RedactorPage({Key? key, this.backImage}) : super(key: key);

  @override
  State<RedactorPage> createState() => _RedactorPageState();
}

class _RedactorPageState extends State<RedactorPage> {
  ScrollController scrollController = ScrollController();

  bool fabIsVisible = true;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      // if (scrollController.offset < -100) ;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              MyFlutterApp.dot_2,
              color: Color(0xFF2E2E2E),
              size: 24,
            ),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              MyFlutterApp.cloud_download,
              color: Color(0xFF2E2E2E),
              size: 24,
            ),
          ),
          IconButton(
            icon: Icon(
              MyFlutterApp.upload,
              color: Color(0xFF2E2E2E),
              size: 24,
            ),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              MyFlutterApp.popup,
              color: Color(0xFF2E2E2E),
              size: 24,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 352),
            child: IconButton(
              onPressed: () {},
              icon: Icon(MyFlutterApp.dot_2),
            ),
          ),
          SafeArea(
            bottom: true,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              width: 366,
              height: 570,
              decoration: BoxDecoration(),
              child: widget.backImage,
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: fabIsVisible,
        child: FloatingActionButton(
          backgroundColor: AppColors.pinkLight,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            setState(() {
              fabIsVisible = false;
            });
            showModalBottomSheet(
              context: context,
              elevation: 10,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ElementsSheet(controller: scrollController),
              ),
            ).then((value) => setState(() => fabIsVisible = true));
          },
        ),
      ),
    );
  }
}
