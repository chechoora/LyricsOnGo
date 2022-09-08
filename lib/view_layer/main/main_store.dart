import 'package:lyrics_on_go/domain_layer/search/search_model.dart';
import 'package:lyrics_on_go/domain_layer/search/search_repository.dart';
import 'package:mobx/mobx.dart';

part 'main_store.g.dart';

class MainStore extends _MainStore with _$MainStore {
  MainStore(SearchRepository infoRepository) : super(infoRepository);
}

abstract class _MainStore with Store {
  _MainStore(this.searchRepository);

  final SearchRepository searchRepository;

  @observable
  bool loading = false;

  @observable
  List<SearchAlbumModel> albums = [];

  Future<void> searchQuery(String newText) async {
    _updateLoading(true);
    final dataStream = searchRepository.getAlbums(newText);
    int count = 0;
    await for (final value in dataStream) {
      _updateData(value);
      if (count == 0) {
        _updateLoading(false);
        count++;
      }
    }
  }

  Future<void> clearQuery() async {
    _updateLoading(true);
    _updateData([]);
    _updateLoading(false);
  }

  @action
  void _updateData(List<SearchAlbumModel> value) {
    albums = value;
  }

  @action
  void _updateLoading(bool loading) {
    this.loading = loading;
  }
}
