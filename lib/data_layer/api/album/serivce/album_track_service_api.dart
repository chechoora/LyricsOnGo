import "dart:async";
import 'package:chopper/chopper.dart';

part 'album_track_service_api.chopper.dart';

@ChopperApi(baseUrl: '/albums')
abstract class AlbumTrackServiceApi extends ChopperService {
  static AlbumTrackServiceApi create([ChopperClient? client]) => _$AlbumTrackServiceApi(client);

  @Get(path: '/{albumId}/tracks')
  Future<Response> getTracks(@Path() int albumId);
}
