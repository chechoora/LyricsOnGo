import 'package:lyrics_on_go/core/isolate/isolate_source.dart';
import 'package:lyrics_on_go/data_layer/api/search/search_mapper_api.dart';
import 'package:lyrics_on_go/data_layer/api/search/search_model_album_api.dart';
import 'package:lyrics_on_go/data_layer/api/search/search_service_api.dart';

class SearchSourceApi extends IsolateSource {
  SearchSourceApi(this.searchService, this.mapper);

  final SearchServiceApi searchService;
  final SearchMapperApi mapper;

  Future<List<SearchAlbumModelApi>> searchAlbums(String query) async {
    return await executeInIsolate(SearchAlbumsOperation(searchService, mapper, query));
  }
}

class SearchAlbumsOperation implements IsolateOperation<List<SearchAlbumModelApi>> {
  SearchAlbumsOperation(this.searchServiceApi, this.mapper, this.query);

  final SearchServiceApi searchServiceApi;
  final SearchMapperApi mapper;
  final String query;

  @override
  Future<List<SearchAlbumModelApi>> execute() async {
    final response = await searchServiceApi.getAlbums(query);
    return mapper.mapAlbums(response);
  }
}
