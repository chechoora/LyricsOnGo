import 'package:lyrics_on_go/data_layer/api/album/album_source_api.dart';
import 'package:lyrics_on_go/data_layer/cache/album/album_source_cache.dart';
import 'package:lyrics_on_go/domain_layer/album/album_mapper.dart';
import 'package:lyrics_on_go/domain_layer/album/model/album_model.dart';

class AlbumRepository {
  final AlbumSourceApi albumSourceApi;
  final AlbumSourceCache albumSourceCache;
  final AlbumMapper mapper;

  AlbumRepository(
    this.albumSourceApi,
    this.albumSourceCache,
    this.mapper,
  );

  Stream<AlbumModel> getAlbum(int albumId) async* {
    final cachedModel = albumSourceCache.getModel();
    if (cachedModel != null) {
      yield cachedModel;
    }
    final apiResult = await albumSourceApi.getAlbum(albumId);
    final mappedModel = mapper.map(apiResult);
    albumSourceCache.updateModel(mappedModel);
    yield mappedModel;
  }
}
