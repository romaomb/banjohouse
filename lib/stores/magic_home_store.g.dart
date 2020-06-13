// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magic_home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MagicHomeStore on _MagicHomeStore, Store {
  final _$connectedDeviceAtom = Atom(name: '_MagicHomeStore.connectedDevice');

  @override
  MagicHome get connectedDevice {
    _$connectedDeviceAtom.reportRead();
    return super.connectedDevice;
  }

  @override
  set connectedDevice(MagicHome value) {
    _$connectedDeviceAtom.reportWrite(value, super.connectedDevice, () {
      super.connectedDevice = value;
    });
  }

  final _$devicesFoundAtom = Atom(name: '_MagicHomeStore.devicesFound');

  @override
  ObservableList<MagicHome> get devicesFound {
    _$devicesFoundAtom.reportRead();
    return super.devicesFound;
  }

  @override
  set devicesFound(ObservableList<MagicHome> value) {
    _$devicesFoundAtom.reportWrite(value, super.devicesFound, () {
      super.devicesFound = value;
    });
  }

  final _$scanAsyncAction = AsyncAction('_MagicHomeStore.scan');

  @override
  Future<void> scan() {
    return _$scanAsyncAction.run(() => super.scan());
  }

  final _$connectToAsyncAction = AsyncAction('_MagicHomeStore.connectTo');

  @override
  Future<void> connectTo(MagicHome device) {
    return _$connectToAsyncAction.run(() => super.connectTo(device));
  }

  @override
  String toString() {
    return '''
connectedDevice: ${connectedDevice},
devicesFound: ${devicesFound}
    ''';
  }
}
