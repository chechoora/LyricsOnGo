import "dart:async";
import 'package:chopper/chopper.dart';

part 'search_service_api.chopper.dart';

@ChopperApi(baseUrl: "/search")
abstract class SearchServiceApi extends ChopperService {
  static SearchServiceApi create([ChopperClient? client]) => _$SearchServiceApi(client);

  @Get(path: '/album')
  Future<Response> getAlbums(@Query('q') String query);
}
