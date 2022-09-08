import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';
import 'package:lyrics_on_go/data_layer/api/album/mapper/album_mapper_api.dart';
import 'package:lyrics_on_go/data_layer/api/album/album_source_api.dart';
import 'package:lyrics_on_go/data_layer/api/album/serivce/album_service_api.dart';
import 'package:lyrics_on_go/data_layer/api/album/serivce/album_track_service_api.dart';
import 'package:lyrics_on_go/data_layer/api/search/search_mapper_api.dart';
import 'package:lyrics_on_go/data_layer/api/search/search_service_api.dart';
import 'package:lyrics_on_go/data_layer/api/search/search_source_api.dart';
import 'package:lyrics_on_go/domain_layer/album/album_mapper.dart';
import 'package:lyrics_on_go/domain_layer/album/album_reposiotry.dart';
import 'package:lyrics_on_go/domain_layer/repository/auth_reposiory.dart';
import 'package:lyrics_on_go/domain_layer/repository/pref_repository.dart';
import 'package:lyrics_on_go/domain_layer/search/search_mapper.dart';
import 'package:lyrics_on_go/domain_layer/search/search_repository.dart';

final getIt = GetIt.instance;

void setupDI() {
  _setupAuth();
  _setupAPI();
  _setupSource();
  _setupRepos();
}

void _setupAuth() {
  final prefRepository = PrefRepository();
  final AuthRepository authRepository = AuthRepository(prefRepository);
  getIt.registerSingleton<AuthRepository>(authRepository);
}

void _setupAPI() {
  final publicApi = ChopperClient(
    baseUrl: "https://genius.com/api",
    services: [
      // Create and pass an instance of the generated service to the client
      SearchServiceApi.create(),
      AlbumServiceApi.create(),
      AlbumTrackServiceApi.create(),
    ],
  );
  getIt.registerSingleton<ChopperClient>(publicApi, instanceName: 'publicApi');

  final privateApi = ChopperClient(
    baseUrl: "https://api.genius.com",
    services: [
      // Create and pass an instance of the generated service to the client
    ],
  );
  getIt.registerSingleton<ChopperClient>(privateApi, instanceName: 'privateApi');
}

void _setupSource() {
  final publicClient = getIt.get<ChopperClient>(instanceName: 'publicApi');

  final searchServiceApi = publicClient.getService<SearchServiceApi>();
  final SearchSourceApi searchSource = SearchSourceApi(searchServiceApi, SearchMapperApi());
  getIt.registerSingleton<SearchSourceApi>(searchSource);

  final albumApi = publicClient.getService<AlbumServiceApi>();
  final trackApi = publicClient.getService<AlbumTrackServiceApi>();

  final albumSourceApi = AlbumSourceApi(
    albumApi: albumApi,
    albumMapperApi: AlbumMapperApi(),
    albumTrackApi: trackApi,
  );
  getIt.registerSingleton<AlbumSourceApi>(albumSourceApi);
}

void _setupRepos() {
  final SearchRepository infoRepository = SearchRepository(getIt.get<SearchSourceApi>(), SearchMapper());
  getIt.registerSingleton<SearchRepository>(infoRepository);

  final AlbumRepository albumRepository = AlbumRepository(getIt.get<AlbumSourceApi>(), AlbumMapper());
  getIt.registerSingleton<AlbumRepository>(albumRepository);
}
