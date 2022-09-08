import 'package:lyrics_on_go/data_layer/api/album/model/album_model_api.dart';
import 'package:lyrics_on_go/domain_layer/album/model/album_model.dart';

class AlbumMapper {
  AlbumModel map(AlbumModelApi modelApi) {
    return AlbumModel(
      albumCover: modelApi.albumCover,
      downloadedState: AlbumDownloadedState.not,
      tracks: modelApi.tracks,
    );
  }
}
