import 'package:flutter/material.dart';
import 'package:lyrics_on_go/domain_layer/search/search_model.dart';

class MainContentWidget extends StatelessWidget {
  const MainContentWidget(
    this.albums, {
    this.onAlbumPick,
    Key? key,
  }) : super(key: key);

  final List<SearchAlbumModel> albums;
  final Function(SearchAlbumModel)? onAlbumPick;

  @override
  Widget build(BuildContext context) {
    if (albums.isEmpty) {
      return const Center(
        child: Text('No data available'),
      );
    } else {
      return GridView.builder(
        itemCount: albums.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 4, crossAxisSpacing: 4),
        itemBuilder: (context, int index) {
          final album = albums[index];
          return GestureDetector(
            child: GridTile(
              footer: GridTileBar(
                title: Text(
                  album.title,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blue.withOpacity(0.9),
              ),
              child: Image.network(album.cowerThumbnailUrl),
            ),
            onTap: () {
              onAlbumPick?.call(album);
            },
          );
        },
      );
    }
  }
}
