import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/presentation/theme/app_text_styles.dart';

class AlbumPageTemplatesBody extends StatelessWidget {
  const AlbumPageTemplatesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Тип шаблонов страниц', style: AppTextStyles.smallTitleBold.copyWith(color: Colors.white)),
              DropdownButton<String>(
                items: [],
                onChanged: (value) {},
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection('album_page_templates').snapshots(),
              builder: (context, templatesSnapshot) {
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
