import 'package:get_it/get_it.dart';
import 'package:lyrics_on_go/repository/auth_reposiory.dart';
import 'package:lyrics_on_go/repository/pref_repository.dart';

final getIt = GetIt.instance;

void setup() {
  final prefRepository = PrefRepository();
  final AuthRepository authRepository = AuthRepository(prefRepository);
  getIt.registerSingleton<AuthRepository>(authRepository);
}
