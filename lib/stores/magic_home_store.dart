import 'dart:io';

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

  @observable
  MagicHome connectedDevice;

  @observable
  ObservableList<MagicHome> devicesFound = ObservableList();

  @action
  Future<void> scan() async {
    print('Scanning');
    final device = await magicHomeRepository.searchDevice(_broadcast);
    if (device != null && !devicesFound.contains(device)) {
      print('New device found ${device.toString()}');
      devicesFound.add(device);
    }
  }

  @action
  Future<void> connectTo(MagicHome device) async {
    print('Connecting');
    final didConnect = await magicHomeRepository.connectTo(device);
    if (didConnect) {
      print('Connected to ${device.toString()}');
      connectedDevice = device;
    }
  }

  Future<void> setColor(int red, int green, int blue) async {
    if (connectedDevice == null) return;
    print('Setting new color ($red, $green, $blue)');
    await magicHomeRepository.setColor(
      LedColor(
        red,
        green,
        blue,
      ),
      connectedDevice.internetAddress,
    );
  }

  void dispose() {
    magicHomeRepository.dispose();
  }
}
