import 'package:flutter/material.dart';
import 'package:photo_album/data/models/album_template.dart';
import 'package:photo_album/data/services/dataBase_services.dart';
import 'package:photo_album/presentation/custom_widgets/album_card.dart';
import 'package:photo_album/presentation/custom_widgets/empty_list_widget.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';

class MyAlbumsPageBody extends StatelessWidget {
  MyAlbumsPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Мои альбомы'),
        actions: [
          Image.asset('assets/images/Logo_small.png'),
        ],
      ),
      body: StreamBuilder<List<AlbumModel>>(
        stream: DataBaseService.instance.localAlbumsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Loader();
          else if (snapshot.hasData && (snapshot.data?.isEmpty ?? false || !snapshot.hasData))
            return EmptyListWidget(message: 'На вашем устройстве нет сохраненных альбомов');
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 110 / 120,
            ),
            padding: AppInsets.insetsAll16,
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return AlbumCard(
                album: snapshot.data!.elementAt(index),
                showText: false,
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
