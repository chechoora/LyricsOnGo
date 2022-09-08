import 'package:flutter/material.dart';
import 'package:lyrics_on_go/di/di.dart';
import 'package:lyrics_on_go/domain_layer/oauth/oauth_launcher.dart';
import 'package:lyrics_on_go/domain_layer/repository/auth_reposiory.dart';
import 'package:lyrics_on_go/view_layer/determine/determine_store.dart';
import 'package:lyrics_on_go/view_layer/routes/routes_const.dart';
import 'package:lyrics_on_go/view_layer/utils/widgets/simple_loading_widget.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loggy/loggy.dart';

class DeterminePage extends StatefulWidget {
  const DeterminePage({Key? key}) : super(key: key);

  @override
  State<DeterminePage> createState() => _DeterminePageState();
}

class _DeterminePageState extends State<DeterminePage> {
  late final OAuthLauncher oauthLauncher;
  late final ReactionDisposer reactionDisposer;
  late final DetermineStore determineStore;

  @override
  void initState() {
    oauthLauncher = OAuthLauncher(onCredentialsObtained: (credentials) {
      determineStore.setCredentials(credentials);
    });
    determineStore = DetermineStore(getIt<AuthRepository>(), oauthLauncher);
    reactionDisposer = reaction(
      (_) => determineStore.isCredentialsReady,
      (bool isCredentialsReady) {
        logDebug('isCredentialsReady: $isCredentialsReady');
        if (isCredentialsReady) {
          Navigator.of(context).pushReplacementNamed(RoutesConst.main);
        }
      },
      onError: (_, __) {
        logError('$_');
        logError('$__');
      },
    );
    determineStore.checkCredentials();
    super.initState();
  }

  @override
  void dispose() {
    reactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Column(
        children: [
          Observer(
            builder: (context) {
              if (determineStore.loading) {
                return const Center(
                  child: SimpleLoadingWidget(),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          Observer(
            builder: (BuildContext context) {
              if (determineStore.isCredentialsReady) {
                return const Text('Credentials are ready');
              } else {
                return determineStore.loading
                    ? const SizedBox.shrink()
                    : Expanded(child: oauthLauncher.createWebView(context));
              }
            },
          )
        ],
      ),
    );
  }
}
