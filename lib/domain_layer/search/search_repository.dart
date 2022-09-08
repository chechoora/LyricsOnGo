import 'package:lyrics_on_go/data_layer/api/search/search_source_api.dart';
import 'package:lyrics_on_go/domain_layer/search/search_mapper.dart';
import 'package:lyrics_on_go/domain_layer/search/search_model.dart';

class SearchRepository {
  final SearchSourceApi searchSource;
  final SearchMapper mapper;

  SearchRepository(this.searchSource, this.mapper);

  Stream<List<SearchAlbumModel>> getAlbums(String query) async* {
    final apiResult = await searchSource.searchAlbums(query);
    yield apiResult.map<SearchAlbumModel>((e) => mapper.map(e)).toList();
  }
}
