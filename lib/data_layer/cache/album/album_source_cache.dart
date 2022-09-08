import 'package:lyrics_on_go/domain_layer/album/model/album_model.dart';

class AlbumSourceCache {
  AlbumModel? _cachedModel;

  AlbumModel? getModel() {
    return _cachedModel;
  }

  void updateModel(AlbumModel model) {
    _cachedModel = model;
  }
}
