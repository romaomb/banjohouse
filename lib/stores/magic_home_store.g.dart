// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magic_home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MagicHomeStore on _MagicHomeStore, Store {
  final _$deviceAtom = Atom(name: '_MagicHomeStore.device');

  @override
  MagicHome get device {
    _$deviceAtom.reportRead();
    return super.device;
  }

  @override
  set device(MagicHome value) {
    _$deviceAtom.reportWrite(value, super.device, () {
      super.device = value;
    });
  }

  final _$connectAsyncAction = AsyncAction('_MagicHomeStore.connect');

  @override
  Future<void> connect() {
    return _$connectAsyncAction.run(() => super.connect());
  }

  @override
  String toString() {
    return '''
device: ${device}
    ''';
  }
}
