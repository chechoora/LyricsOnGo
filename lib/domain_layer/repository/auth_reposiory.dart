import 'package:lyrics_on_go/domain_layer/oauth/auth_model.dart';
import 'package:lyrics_on_go/domain_layer/repository/pref_repository.dart';

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
