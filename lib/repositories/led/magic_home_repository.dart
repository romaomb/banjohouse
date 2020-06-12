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
      return MagicHome(
        internetAddress: InternetAddress(rawMagicHome[0]),
        id: rawMagicHome[1],
        model: rawMagicHome[2],
      );
    }

    return null;
  }

  Future<void> sendColor(LedColor color, InternetAddress address) async {
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
