import 'package:flutter/material.dart';
import 'package:lyrics_on_go/domain_layer/search/search_model.dart';
import 'package:lyrics_on_go/view_layer/album/album_page.dart';
import 'package:lyrics_on_go/view_layer/determine/determine_page.dart';
import 'package:lyrics_on_go/view_layer/main/main_page.dart';
import 'package:lyrics_on_go/view_layer/routes/routes_const.dart';
import 'package:lyrics_on_go/view_layer/utils/pages/not_found_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesConst.determine:
        return MaterialPageRoute(builder: (_) => const DeterminePage());
      case RoutesConst.main:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case RoutesConst.album:
        final SearchAlbumModel modelFromSearch = settings.arguments as SearchAlbumModel;
        return MaterialPageRoute(builder: (_) => AlbumPage(initialModelFromSearch: modelFromSearch));
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
    }
  }
}
