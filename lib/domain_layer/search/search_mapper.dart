import 'package:lyrics_on_go/data_layer/api/search/search_model_album_api.dart';
import 'package:lyrics_on_go/domain_layer/search/search_model.dart';

class SearchMapper {
  SearchAlbumModel map(SearchAlbumModelApi modelApi) {
    return SearchAlbumModel(
      id: modelApi.id,
      title: modelApi.title,
      cowerThumbnailUrl: modelApi.cowerThumbnailUrl,
    );
  }
}
