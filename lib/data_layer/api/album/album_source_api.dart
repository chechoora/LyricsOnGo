import 'package:lyrics_on_go/core/isolate/isolate_source.dart';
import 'package:lyrics_on_go/data_layer/api/album/mapper/album_mapper_api.dart';
import 'package:lyrics_on_go/data_layer/api/album/serivce/album_service_api.dart';
import 'package:lyrics_on_go/data_layer/api/album/serivce/album_track_service_api.dart';
import 'package:lyrics_on_go/data_layer/api/album/model/album_model_api.dart';

class AlbumSourceApi extends IsolateSource {
  AlbumSourceApi({
    required this.albumApi,
    required this.albumMapperApi,
    required this.albumTrackApi,
  });

  final AlbumServiceApi albumApi;
  final AlbumMapperApi albumMapperApi;
  final AlbumTrackServiceApi albumTrackApi;

  Future<AlbumModelApi> getAlbum(int albumId) async {
    return await executeInIsolate(GetAlbumsOperation(albumApi, albumMapperApi, albumTrackApi, albumId));
  }
}

class GetAlbumsOperation implements IsolateOperation<AlbumModelApi> {
  final AlbumServiceApi albumApi;
  final AlbumMapperApi albumMapperApi;
  final AlbumTrackServiceApi albumTrackApi;
  final int albumId;

  GetAlbumsOperation(
    this.albumApi,
    this.albumMapperApi,
    this.albumTrackApi,
    this.albumId,
  );

  @override
  Future<AlbumModelApi> execute() async {
    final albumApiResponse = await albumApi.getAlbumInfo(albumId);
    final albumTrackApiResponse = await albumTrackApi.getTracks(albumId);
    return albumMapperApi.mapToAlbumInfo(albumApiResponse, albumTrackApiResponse);
  }
}
