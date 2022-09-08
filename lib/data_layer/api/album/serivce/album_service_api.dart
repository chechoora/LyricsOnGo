import "dart:async";
import 'package:chopper/chopper.dart';

part 'album_service_api.chopper.dart';

@ChopperApi(baseUrl: "/albums")
abstract class AlbumServiceApi extends ChopperService {
  static AlbumServiceApi create([ChopperClient? client]) => _$AlbumServiceApi(client);

  @Get(path: '/{albumId}')
  Future<Response> getAlbumInfo(@Path() int albumId);
}
