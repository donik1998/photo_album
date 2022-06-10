import 'package:flutter/material.dart';
import 'package:photo_album/data/models/album_model.dart';
import 'package:photo_album/data/services/dataBase_services.dart';
import 'package:photo_album/presentation/custom_widgets/album_card.dart';
import 'package:photo_album/presentation/custom_widgets/empty_list_widget.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/state/main_page/main_page_body_state.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';
import 'package:photo_album/presentation/utils/routes.dart';
import 'package:provider/provider.dart';

class AllLocalAlbumsPage extends StatelessWidget {
  const AllLocalAlbumsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: AppInsets.insetsAll16,
        child: FutureBuilder<List<AlbumModel>>(
          future: DataBaseService.instance.getAlbumFromDB(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Loader();
            else if (!snapshot.hasData)
              return EmptyListWidget(message: 'Не удалось найти сохраненные альбомы на этом устройстве');
            else
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return AlbumCard(
                    album: snapshot.data!.elementAt(index),
                    showText: true,
                    onAlbumDeleted: () {
                      DataBaseService.instance.deleteAlbum(snapshot.data!.elementAt(index));
                    },
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.EDITOR_PAGE,
                      arguments: RedactorPageArgs(
                        decorationCategories: context.read<MainPageBodyState>().decorationCategories,
                        albumBacks: context.read<MainPageBodyState>().albumBacks,
                        albumPageTemplateCategories: context.read<MainPageBodyState>().templateCategories,
                        localAlbum: snapshot.data!.elementAt(index),
                      ),
                    ),
                  );
                },
              );
          },
        ),
      ),
    );
  }
}
