import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:lyrics_on_go/domain_layer/oauth/auth_model.dart';
import 'package:oauth2/oauth2.dart';

class OAuthLauncher {
  OAuthLauncher({this.onCredentialsObtained});

  final authorizationEndpoint = Uri.parse('https://api.genius.com/oauth/authorize');
  final tokenEndpoint = Uri.parse('https://api.genius.com/oauth/token');
  final redirectUrl = Uri.parse('https://lyrics_on_go_redirect_uri/');

  final clientId = 'Ia5Qr4_9TdDKOxTqdPyo91_GfF961zVMX1Zyj2jkX530O7XOLwTc2XkkjOc7rtmj';
  final clientSecret = '5JMoWkarlvzFRbtV2bS9MCj3IBgWmiOWDT9YtLXP-qNjRMM8WIt7qgXzMU_nDQpwSDfMIEi3rvEsEXh48vbJvg';

  final Function(AuthModel)? onCredentialsObtained;

  AuthorizationCodeGrant? _grant;
  Uri? _authUrl;

  void initAuthFlow() {
    _authUrl = _buildAuthorizationUrl();
  }

  InAppWebView createWebView(BuildContext context) {
    final authUrl = _authUrl;
    if (authUrl == null) {
      throw ArgumentError('Flow is not initialized');
    }
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: authUrl,
      ),
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          cacheEnabled: false,
          useShouldOverrideUrlLoading: true,
          userAgent:
              "Mozilla/5.0 (Linux; Android 9; LG-H870 Build/PKQ1.190522.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36",
        ),
        android: AndroidInAppWebViewOptions(useHybridComposition: true),
      ),
      onWebViewCreated: (controller) {
        controller.clearCache();
        final cookieManager = CookieManager();
        cookieManager.deleteAllCookies();
      },
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        final uri = navigationAction.request.url!;
        if (uri.toString().startsWith(redirectUrl.toString())) {
          final responseUrl = uri;
          _launch(responseUrl);
          return NavigationActionPolicy.CANCEL;
        }
        return NavigationActionPolicy.ALLOW;
      },
    );
  }

  void _launch(Uri responseUrl) {
    final grant = _getGrant();
    grant.handleAuthorizationResponse(responseUrl.queryParameters).then((client) {
      final credentials = client.credentials;
      onCredentialsObtained?.call(AuthModel(credentials.accessToken, credentials.refreshToken));
    });
  }

  Uri _buildAuthorizationUrl() {
    final url = _getGrant().getAuthorizationUrl(redirectUrl, scopes: ['me']);
    return url;
  }

  AuthorizationCodeGrant _getGrant() {
    if (_grant == null) {
      return _grant = AuthorizationCodeGrant(
        clientId,
        authorizationEndpoint,
        tokenEndpoint,
        secret: clientSecret,
      );
    } else {
      return _grant!;
    }
  }
}
