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

  final _$isOnAtom = Atom(name: '_MagicHomeStore.isOn');

  @override
  bool get isOn {
    _$isOnAtom.reportRead();
    return super.isOn;
  }

  @override
  set isOn(bool value) {
    _$isOnAtom.reportWrite(value, super.isOn, () {
      super.isOn = value;
    });
  }

  final _$currentColorAtom = Atom(name: '_MagicHomeStore.currentColor');

  @override
  LedColor get currentColor {
    _$currentColorAtom.reportRead();
    return super.currentColor;
  }

  @override
  set currentColor(LedColor value) {
    _$currentColorAtom.reportWrite(value, super.currentColor, () {
      super.currentColor = value;
    });
  }

  final _$connectToAsyncAction = AsyncAction('_MagicHomeStore.connectTo');

  @override
  Future<void> connectTo(MagicHome device) {
    return _$connectToAsyncAction.run(() => super.connectTo(device));
  }

  final _$_MagicHomeStoreActionController =
      ActionController(name: '_MagicHomeStore');

  @override
  void _onDeviceFound(MagicHome device) {
    final _$actionInfo = _$_MagicHomeStoreActionController.startAction(
        name: '_MagicHomeStore._onDeviceFound');
    try {
      return super._onDeviceFound(device);
    } finally {
      _$_MagicHomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
connectedDevice: ${connectedDevice},
devicesFound: ${devicesFound},
isOn: ${isOn},
currentColor: ${currentColor}
    ''';
  }
}
