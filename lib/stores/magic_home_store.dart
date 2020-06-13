import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import '../models/led_color.dart';
import '../models/magic_home.dart';
import '../repositories/led/magic_home_repository.dart';

part 'magic_home_store.g.dart';

class MagicHomeStore extends _MagicHomeStore with _$MagicHomeStore {
  MagicHomeStore({@required MagicHomeRepository magicHomeRepository})
      : assert(magicHomeRepository != null),
        super(magicHomeRepository);
}

abstract class _MagicHomeStore with Store {
  _MagicHomeStore(this.magicHomeRepository);

  final MagicHomeRepository magicHomeRepository;

  /// TODO: get connected network address
  final _broadcast = InternetAddress('192.168.0.255');
  final _random = Random();

  @observable
  MagicHome connectedDevice;

  @observable
  ObservableList<MagicHome> devicesFound = ObservableList();

  @observable
  bool isOn = false;

  @observable
  LedColor currentColor;

  StreamSubscription _deviceSubscription;

  void scan() async {
    print('Scanning');

    _deviceSubscription?.cancel();
    _deviceSubscription = magicHomeRepository.magicHome.listen(_onDeviceFound);

    await magicHomeRepository.searchForDevices(_broadcast);
  }

  @action
  void _onDeviceFound(MagicHome device) {
    if (!devicesFound.contains(device)) {
      print('New device found ${device.toString()}');
      devicesFound.add(device);
    }
  }

  @action
  Future<void> connectTo(MagicHome device) async {
    await magicHomeRepository.stopSearch();
    final didConnect = await magicHomeRepository.connectTo(device);
    if (didConnect) {
      print('Connected to ${device.toString()}');
      connectedDevice = device;
    }
  }

  Future<void> setRandomColor() => setColor(
        _random.nextInt(255),
        _random.nextInt(255),
        _random.nextInt(255),
      );

  Future<void> setColor(int red, int green, int blue) async {
    if (connectedDevice == null) return;

    print('Setting new color ($red, $green, $blue)');
    currentColor = LedColor(red, green, blue);

    await magicHomeRepository.setColor(
      connectedDevice,
      currentColor,
    );
  }

  void togglePower() {
    isOn = !isOn;
    magicHomeRepository.togglePower(connectedDevice, turnOn: isOn);
  }

  void dispose() {
    magicHomeRepository.dispose();
  }
}
