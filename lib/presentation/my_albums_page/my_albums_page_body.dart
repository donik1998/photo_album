import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_album/presentation/custom_widgets/album_card.dart';
import 'package:photo_album/presentation/custom_widgets/empty_list_widget.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/my_albums_page/bloc/my_albums_page_cubit.dart';
import 'package:photo_album/presentation/my_albums_page/bloc/my_albums_page_state.dart';

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
      body: BlocConsumer<MyAlbumsPageCubit, MyAlbumsPageState>(
        bloc: context.read<MyAlbumsPageCubit>(),
        listener: (context, state) {},
        builder: (context, state) {
          if (state is MyAlbumsPageLoading)
            return Loader();
          else if (state is MyAlbumsPageSuccess && state.albums.isEmpty)
            return EmptyListWidget(message: 'На вашем устройстве не найдено сохраненных альбомов');
          else if (state is MyAlbumsPageSuccess && state.albums.isNotEmpty)
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              padding: EdgeInsets.all(10),
              itemCount: state.albums.length,
              itemBuilder: (BuildContext context, int index) {
                return AlbumCard(album: state.albums.elementAt(index));
              },
            );
          else
            return Container();
        },
      ),
    );
  }
}
