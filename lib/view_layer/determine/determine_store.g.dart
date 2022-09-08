// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'determine_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetermineStore on _DetermineStore, Store {
  late final _$loadingAtom =
      Atom(name: '_DetermineStore.loading', context: context);

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

  late final _$isCredentialsReadyAtom =
      Atom(name: '_DetermineStore.isCredentialsReady', context: context);

  @override
  bool get isCredentialsReady {
    _$isCredentialsReadyAtom.reportRead();
    return super.isCredentialsReady;
  }

  @override
  set isCredentialsReady(bool value) {
    _$isCredentialsReadyAtom.reportWrite(value, super.isCredentialsReady, () {
      super.isCredentialsReady = value;
    });
  }

  late final _$checkCredentialsAsyncAction =
      AsyncAction('_DetermineStore.checkCredentials', context: context);

  @override
  Future<void> checkCredentials() {
    return _$checkCredentialsAsyncAction.run(() => super.checkCredentials());
  }

  late final _$_DetermineStoreActionController =
      ActionController(name: '_DetermineStore', context: context);

  @override
  void setCredentials(AuthModel authModel) {
    final _$actionInfo = _$_DetermineStoreActionController.startAction(
        name: '_DetermineStore.setCredentials');
    try {
      return super.setCredentials(authModel);
    } finally {
      _$_DetermineStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
isCredentialsReady: ${isCredentialsReady}
    ''';
  }
}
