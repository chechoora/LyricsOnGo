import 'package:lyrics_on_go/model/auth_model.dart';
import 'package:lyrics_on_go/oauth/oauth_launcher.dart';
import 'package:lyrics_on_go/repository/auth_reposiory.dart';
import 'package:mobx/mobx.dart';

part 'determine_store.g.dart';

// This is the class used by rest of your codebase
class DetermineStore extends _DetermineStore with _$DetermineStore {
  DetermineStore(AuthRepository authRepository, OAuthLauncher oAuthLauncher) : super(authRepository, oAuthLauncher);
}

abstract class _DetermineStore with Store {
  _DetermineStore(this.authRepository, this.oAuthLauncher);

  final AuthRepository authRepository;
  final OAuthLauncher oAuthLauncher;

  @observable
  bool loading = true;
  @observable
  bool isCredentialsReady = false;

  @action
  void checkCredentials() async {
    loading = true;
    final model = await authRepository.getAuthModel();
    if (model != null) {
      isCredentialsReady = true;
    } else {
      oAuthLauncher.initAuthFlow();
      isCredentialsReady = false;
    }
    loading = false;
  }

  @action
  void setCredentials(AuthModel authModel) {
    loading = true;
    authRepository.updateAuthModel(authModel);
    isCredentialsReady = true;
    loading = false;
  }
}
