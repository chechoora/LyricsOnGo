import 'package:lyrics_on_go/utils/type_def.dart';

class AuthModel {
  AuthModel(this.accessToken, this.refreshToken);

  factory AuthModel.fromJson(JsonMap json) {
    return AuthModel(
      json['accessToken'],
      json['refreshToken'],
    );
  }

  final String accessToken;
  final String? refreshToken;

  JsonMap toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
}
