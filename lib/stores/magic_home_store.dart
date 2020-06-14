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
  StreamSubscription _magicHomeInfoSubscription;

  void scan() async {
    _deviceSubscription?.cancel();
    _deviceSubscription = magicHomeRepository.magicHome.listen(_onDeviceFound);
    await magicHomeRepository.searchForDevices(_broadcast);
  }

  @action
  void _onDeviceFound(MagicHome device) {
    if (!devicesFound.contains(device)) {
      devicesFound.add(device);
    }
  }

  @action
  Future<void> connectTo(MagicHome device) async {
    await magicHomeRepository.stopSearch();
    final didConnect = await magicHomeRepository.connectTo(device);
    if (didConnect) {
      connectedDevice = device;
      _listenForInfo();
    }
  }

  @action
  void _listenForInfo() {
    _magicHomeInfoSubscription = magicHomeRepository.magicHomeInfo.listen(
      (info) {
        isOn = info.isOn;
        currentColor = info.color;
      },
    );
  }

  void setRandomColor() => setRgbColor(
        _random.nextInt(255),
        _random.nextInt(255),
        _random.nextInt(255),
      );

  @action
  void setRgbColor(int red, int green, int blue) {
    if (connectedDevice == null) return;
    currentColor = LedColor(red, green, blue);
    magicHomeRepository.setColor(
      connectedDevice,
      currentColor,
    );
  }

  @action
  void togglePower() {
    isOn = !isOn;
    magicHomeRepository.togglePower(connectedDevice, turnOn: isOn);
  }

  @action
  void getInfo(MagicHome device) =>
      magicHomeRepository.getInfo(connectedDevice);

  void dispose() {
    magicHomeRepository.dispose();
    _magicHomeInfoSubscription?.cancel();
    _deviceSubscription?.cancel();
  }
}
