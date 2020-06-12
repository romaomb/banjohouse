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
  MagicHome device;

  @action
  Future<void> connect() async {
    print('Connecting');
    device = await magicHomeRepository.searchDevice(_broadcast);
    print('New device $device');
  }

  Future<void> setColor(int red, int green, int blue) async {
    if (device == null) return;
    await magicHomeRepository.sendColor(
        LedColor(red, green, blue), device.internetAddress);
  }

  void dispose() {
    magicHomeRepository.dispose();
  }
}
