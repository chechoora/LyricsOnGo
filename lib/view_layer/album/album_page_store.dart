import 'package:lyrics_on_go/domain_layer/album/album_reposiotry.dart';
import 'package:lyrics_on_go/domain_layer/album/model/album_model.dart';
import 'package:mobx/mobx.dart';

part 'album_page_store.g.dart';

class AlbumPageStore extends _AlbumPageStore with _$AlbumPageStore {
  AlbumPageStore(AlbumRepository albumRepository) : super(albumRepository);
}

abstract class _AlbumPageStore with Store {
  final AlbumRepository albumRepository;

  _AlbumPageStore(this.albumRepository);

  @observable
  bool loading = false;

  late AlbumModel model;

  Future<void> loadAlbumData(int albumId) async {
    _updateLoading(true);
    final dataStream = albumRepository.getAlbum(albumId);
    int count = 0;
    await for (final value in dataStream) {
      model = value;
      _updateLoading(false);
      if (count == 0) {
        count++;
      }
    }
    _updateLoading(false);
  }

  @action
  void _updateLoading(bool loading) {
    this.loading = loading;
  }
}
