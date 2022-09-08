import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lyrics_on_go/di/di.dart';
import 'package:lyrics_on_go/domain_layer/search/search_repository.dart';
import 'package:lyrics_on_go/view_layer/main/main_content_widget.dart';
import 'package:lyrics_on_go/view_layer/main/main_store.dart';
import 'package:lyrics_on_go/view_layer/routes/routes_const.dart';
import 'package:lyrics_on_go/view_layer/utils/debouncer.dart';
import 'package:lyrics_on_go/view_layer/utils/widgets/search_app_bar_widget.dart';
import 'package:lyrics_on_go/view_layer/utils/widgets/simple_loading_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _debouncer = Debouncer(milliseconds: 200);

  late final MainStore mainStore;

  @override
  void initState() {
    mainStore = MainStore(getIt<SearchRepository>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBarWidget(
        onChanged: (newText) {
          _debouncer.run(() {
            mainStore.searchQuery(newText);
          });
        },
        onClear: () {
          _debouncer.run(() {
            mainStore.clearQuery();
          });
        },
      ),
      body: Observer(
        builder: (context) {
          return mainStore.loading
              ? const Center(
                  child: SimpleLoadingWidget(),
                )
              : MainContentWidget(
                  mainStore.albums,
                  onAlbumPick: (album) {
                    Navigator.of(context).pushNamed(
                      RoutesConst.album,
                      arguments: album,
                    );
                  },
                );
        },
      ),
    );
  }
}
