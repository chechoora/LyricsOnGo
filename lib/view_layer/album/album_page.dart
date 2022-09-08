import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lyrics_on_go/di/di.dart';
import 'package:lyrics_on_go/domain_layer/album/album_reposiotry.dart';
import 'package:lyrics_on_go/domain_layer/album/model/album_model.dart';
import 'package:lyrics_on_go/domain_layer/search/search_model.dart';
import 'package:lyrics_on_go/view_layer/album/album_page_store.dart';
import 'package:lyrics_on_go/view_layer/utils/widgets/simple_loading_widget.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({
    required this.initialModelFromSearch,
    Key? key,
  }) : super(key: key);

  final SearchAlbumModel initialModelFromSearch;

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late final AlbumPageStore albumPageStore;

  @override
  void initState() {
    albumPageStore = AlbumPageStore(getIt<AlbumRepository>());
    albumPageStore.loadAlbumData(widget.initialModelFromSearch.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialModelFromSearch.title),
      ),
      body: Observer(
        builder: (context) {
          if (albumPageStore.loading) {
            return const Center(
              child: SimpleLoadingWidget(),
            );
          }
          final model = albumPageStore.model;
          return Column(
            children: [
              Expanded(
                child: _buildContent(model),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(AlbumModel model) {
    final tracks = model.tracks;
    return ListView.builder(
      itemCount: tracks.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _buildAlbumCover(model.albumCover);
        }
        final track = tracks[index - 1];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            children: [
              Text('# ${track.trackNumber}'),
              const SizedBox(width: 8),
              Text(track.title),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAlbumCover(String albumCover) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Image.network(albumCover),
      ),
    );
  }
}
