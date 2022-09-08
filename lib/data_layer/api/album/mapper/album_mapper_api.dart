import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:lyrics_on_go/data_layer/api/album/model/album_model_api.dart';
import 'package:lyrics_on_go/domain_layer/album/model/album_track.dart';

class AlbumMapperApi {
  Future<AlbumModelApi> mapToAlbumInfo(
    Response albumApiResponse,
    Response albumTrackApiResponse,
  ) async {
    final albumBody = jsonDecode(albumApiResponse.body);

    final albumResponse = albumBody['response'];
    final album = albumResponse['album'];
    final albumArtURL = album['cover_art_url'];
    final title = album['name'];

    final tracksBody = jsonDecode(albumTrackApiResponse.body);
    final tracksResponse = tracksBody['response'];
    final tracksList = tracksResponse['tracks'] as List;

    final List<AlbumTrack> tracks = [];
    for (var track in tracksList) {
      final int number = track['number'];
      final songMap = track['song'];
      final title = songMap['title_with_featured'];
      tracks.add(AlbumTrack(
        trackNumber: number,
        title: title,
        downloadedState: TrackDownloadedState.not,
      ));
    }
    return AlbumModelApi(
      title: title,
      albumCover: albumArtURL,
      tracks: tracks,
    );
  }
}
