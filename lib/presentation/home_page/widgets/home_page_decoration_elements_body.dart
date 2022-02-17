import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/models/album_template.dart';
import 'package:photo_album/presentation/custom_widgets/album_card.dart';
import 'package:photo_album/presentation/custom_widgets/empty_list_widget.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';

class HomePageDecorationElementsBody extends StatelessWidget {
  const HomePageDecorationElementsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('decorations').snapshots(),
      builder: (context, ordersSnapshot) {
        if (ordersSnapshot.connectionState == ConnectionState.waiting)
          return Loader();
        else if (!ordersSnapshot.hasData || (ordersSnapshot.data?.docs.isEmpty ?? false))
          return EmptyListWidget();
        else
          return ListView.builder(
            padding: AppInsets.horizontalInsets36,
            itemCount: ordersSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = ordersSnapshot.data!.docs.elementAt(index);
              return AlbumCard(album: Album.fromDoc(doc));
            },
          );
      },
    );
  }
}
