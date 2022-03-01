import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_album/presentation/theme/different_icons.dart';

import '../theme/app_icons.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class RedactorPage extends StatefulWidget {
  final Widget? backImage;

  RedactorPage({Key? key, this.backImage}) : super(key: key);

  @override
  State<RedactorPage> createState() => _RedactorPageState();
}

ScrollController scrollController2 = ScrollController();

class _RedactorPageState extends State<RedactorPage> {
  ScrollController scrollController = ScrollController();
  PersistentBottomSheetController? bottomSheetController;
  PersistentBottomSheetController? bottomSheetController2;
  bool fabIsVisible = true;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset < -100) {
        bottomSheetController!.close();
      }
    });
    scrollController2.addListener(() {
      if (scrollController2.offset < -100) {
        bottomSheetController!.close();
      }
      setState(() {
        fabIsVisible = scrollController2.position.userScrollDirection == ScrollDirection.forward;
      });
    });
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
      floatingActionButton: AnimatedOpacity(
        duration: Duration(milliseconds: 100),
        opacity: fabIsVisible ? 1 : 0,
        child: FloatingActionButton(
          backgroundColor: Color(0xFFE11577),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              bottomSheetController = modalBottomSheetMenu(context);
            });
          },
        ),
      ),
    );
  }

  Widget _gridview(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        child: GridView.builder(
            controller: scrollController,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(0),
            scrollDirection: Axis.vertical,
            itemCount: 11,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 5,
              crossAxisSpacing: 0,
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  IconButton(
                      icon: IconButtons.icons.elementAt(index),
                      onPressed: () {
                        // setState(() {
                        //   bottomSheetController2 = modalBottomSheetMenu2(context, index);
                        // });
                      }),
                  Text(
                    IconButtons.labels.elementAt(index),
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF2E2E2E),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  modalBottomSheetMenu(BuildContext context) {
    return _scaffoldKey.currentState?.showBottomSheet((context) => _gridview(context));
  }

  // modalBottomSheetMenu2(BuildContext context,int index){
  //   return _scaffoldKey.currentState?.showBottomSheet((context) => AllStuffWindow());
  // }

}

class AllStuffWindow extends StatefulWidget {
  final int pageIndex;

  AllStuffWindow(Key? key, this.pageIndex) : super(key: key);

  @override
  State<AllStuffWindow> createState() => _AllStuffWindowState();
}

class _AllStuffWindowState extends State<AllStuffWindow> {
  Widget? _currentPage;

  //    @override
  // void initState() {
  //   super.initState();
  //   _currentPage = IconButtons.widgets.elementAt(widget.pageIndex);
  // }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
