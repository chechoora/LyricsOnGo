// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'album_track.freezed.dart';

// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'album_track.g.dart';

@freezed
class AlbumTrack with _$AlbumTrack {
  const factory AlbumTrack({
    required int trackNumber,
    required String title,
    required TrackDownloadedState downloadedState,
  }) = _AlbumTrack;

  factory AlbumTrack.fromJson(Map<String, Object?> json) => _$AlbumTrackFromJson(json);
}

enum TrackDownloadedState { downloaded, not }
