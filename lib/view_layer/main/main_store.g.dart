// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainStore on _MainStore, Store {
  late final _$loadingAtom = Atom(name: '_MainStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$albumsAtom = Atom(name: '_MainStore.albums', context: context);

  @override
  List<SearchAlbumModel> get albums {
    _$albumsAtom.reportRead();
    return super.albums;
  }

  @override
  set albums(List<SearchAlbumModel> value) {
    _$albumsAtom.reportWrite(value, super.albums, () {
      super.albums = value;
    });
  }

  late final _$_MainStoreActionController =
      ActionController(name: '_MainStore', context: context);

  @override
  void _updateData(List<SearchAlbumModel> value) {
    final _$actionInfo = _$_MainStoreActionController.startAction(
        name: '_MainStore._updateData');
    try {
      return super._updateData(value);
    } finally {
      _$_MainStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _updateLoading(bool loading) {
    final _$actionInfo = _$_MainStoreActionController.startAction(
        name: '_MainStore._updateLoading');
    try {
      return super._updateLoading(loading);
    } finally {
      _$_MainStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
albums: ${albums}
    ''';
  }
}
