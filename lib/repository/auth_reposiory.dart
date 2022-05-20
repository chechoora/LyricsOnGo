import 'package:lyrics_on_go/model/auth_model.dart';
import 'package:lyrics_on_go/repository/pref_repository.dart';

class AuthRepository {
  AuthRepository(this.prefRepository);

  final PrefRepository prefRepository;

  Future<AuthModel?> getAuthModel() async {
    final jsonModel = await prefRepository.getJson(authModelKey);
    if (jsonModel == null) {
      return null;
    }
    return AuthModel.fromJson(jsonModel);
  }

  Future<void> updateAuthModel(AuthModel model) {
    return prefRepository.setJson(authModelKey, model.toJson());
  }
}

const String authModelKey = 'authModelKey';
