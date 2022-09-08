import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:lyrics_on_go/data_layer/api/search/search_model_album_api.dart';

class SearchMapperApi {
  List<SearchAlbumModelApi> mapAlbums(Response response) {
    final body = response.body;
    final jsonBody = jsonDecode(body);
    return _decodeToAlbumModel(jsonBody);
  }

  List<SearchAlbumModelApi> _decodeToAlbumModel(Map jsonBody) {
    final List<SearchAlbumModelApi> models = [];
    final response = jsonBody['response'];
    final sections = response['sections'];
    final List hits = sections.first['hits'];
    for (var hit in hits) {
      final type = hit['type'];
      if (type == 'album') {
        final result = hit['result'];
        final int id = result['id'];
        final String title = result['full_title'];
        final String cowerThumbnailUrl = result['cover_art_thumbnail_url'];
        models.add(SearchAlbumModelApi(
          id: id,
          title: title,
          cowerThumbnailUrl: cowerThumbnailUrl,
        ));
      }
    }
    return models;
  }
}
