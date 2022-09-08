import 'package:lyrics_on_go/data_layer/api/album/album_source_api.dart';
import 'package:lyrics_on_go/domain_layer/album/album_mapper.dart';
import 'package:lyrics_on_go/domain_layer/album/model/album_model.dart';

class AlbumRepository {
  final AlbumSourceApi albumSourceApi;
  final AlbumMapper mapper;

  AlbumRepository(this.albumSourceApi, this.mapper);

  Stream<AlbumModel> getAlbum(int albumId) async* {
    final apiResult = await albumSourceApi.getAlbum(albumId);
    yield mapper.map(apiResult);
  }
}
