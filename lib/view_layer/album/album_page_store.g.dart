// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AlbumPageStore on _AlbumPageStore, Store {
  late final _$loadingAtom =
      Atom(name: '_AlbumPageStore.loading', context: context);

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

  late final _$_AlbumPageStoreActionController =
      ActionController(name: '_AlbumPageStore', context: context);

  @override
  void _updateLoading(bool loading) {
    final _$actionInfo = _$_AlbumPageStoreActionController.startAction(
        name: '_AlbumPageStore._updateLoading');
    try {
      return super._updateLoading(loading);
    } finally {
      _$_AlbumPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading}
    ''';
  }
}
