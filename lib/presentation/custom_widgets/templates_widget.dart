import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

import '../../data/models/album_template.dart';

class TemplatesWidget extends StatelessWidget {
  const TemplatesWidget(
      {Key? key,
      required this.dataList,
      required this.title,
      required this.type})
      : super(key: key);
  final List<Album> dataList;
  final String title;
  final String type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.28,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              title,
              style: AppTextStyles.ttxt1,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Expanded(
            child: ListView.builder(
              //shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(dataList[index].thumbnailLink)),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        type,
                        style: AppTextStyles.txt13,
                      ),
                    ),
                  ],
                );
              },
              scrollDirection: Axis.horizontal,
              physics: ScrollPhysics(),
              itemCount: dataList.length,
            ),
          ),
        ],
      ),
    );
  }
}

class ResolutionTemplate extends StatelessWidget {
  const ResolutionTemplate(
      {Key? key, required this.size, required this.itemCount})
      : super(key: key);
  final List size;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 110,
            height: 110,
            margin: EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Color(0xFFC9C9C9),
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFE11577),
                    Color(0xFFFF5858),
                  ]),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(
                'assets/svgs/book.svg',
                color: Colors.white,
                width: 44,
                height: 44,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                size[index],
                style: AppTextStyles.txt13.copyWith(color: Colors.white),
              ),
            ]),
          );
        },
        itemCount: itemCount,
      ),
    );
  }
}
