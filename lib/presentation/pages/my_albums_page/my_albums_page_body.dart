import 'package:flutter/material.dart';
import 'package:photo_album/presentation/custom_widgets/album_card.dart';
import 'package:photo_album/presentation/custom_widgets/empty_list_widget.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/state/main_page/my_albums_body_state.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<MyAlbumsBodyState>(
        builder: (context, state, child) {
          if (state.loading)
            return Loader();
          else if (state.localAlbums.isEmpty)
            return EmptyListWidget(message: 'На вашем устройстве нет сохраненных альбомов');
          else
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              padding: EdgeInsets.all(10),
              itemCount: state.localAlbums.length,
              itemBuilder: (BuildContext context, int index) {
                return AlbumCard(album: state.localAlbums.elementAt(index));
              },
            );
        },
      ),
    );
  }
}
