import 'dart:io';

import '../../models/led_color.dart';

import '../../models/magic_home.dart';
import '../../services/magic_home_service.dart';

import 'led_repository.dart';

class MagicHomeRepository implements LedRepository {
  const MagicHomeRepository(this.magicHomeService);

  final MagicHomeService magicHomeService;

  Future<MagicHome> searchDevice(InternetAddress broadcastAddress) async {
    final data = await magicHomeService.find(broadcastAddress);

    if (data != null) {
      final rawMagicHome = data.split(',');
      print('RawData: $rawMagicHome');
      return MagicHome(
        internetAddress: InternetAddress(rawMagicHome[0]),
        mac: rawMagicHome[1],
        model: rawMagicHome[2],
      );
    }

    return null;
  }

  Future<bool> connectTo(MagicHome device) async =>
      magicHomeService.connect(device.internetAddress);

  Future<void> setColor(LedColor color, InternetAddress address) async {
    final message = [
      color.persist ? 0x31 : 0x41,
      color.red,
      color.green,
      color.blue,
      0x00,
      0x00,
      0x0F,
    ];

    await magicHomeService.send(message, address);
  }

  void dispose() {
    magicHomeService.dispose();
  }
}
