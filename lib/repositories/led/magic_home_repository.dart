import 'dart:async';
import 'dart:io';

import '../../models/led_color.dart';

import '../../models/magic_home.dart';
import '../../services/magic_home_service.dart';

import 'led_repository.dart';

class MagicHomeRepository implements LedRepository {
  final MagicHomeService magicHomeService;

  MagicHomeRepository(this.magicHomeService);

  static const _messageOn = [0x71, 0x23, 0x0f];
  static const _messageOff = [0x71, 0x24, 0x0f];

  final _magicHome = StreamController<MagicHome>();
  StreamSink get _magicHomeSink => _magicHome.sink;
  Stream<MagicHome> get magicHome => _magicHome.stream.asBroadcastStream();

  StreamSubscription _datagramSubscription;

  Future<void> searchForDevices(InternetAddress broadcastAddress) async {
    print('Start search - repo');

    _datagramSubscription?.cancel();
    _datagramSubscription =
        magicHomeService.datagram.listen(_onDatagramReceived);

    await magicHomeService.startSearch(broadcastAddress);
  }

  void _onDatagramReceived(String datagram) {
    print('Raw magicHome');
    final rawMagicHome = datagram.split(',');
    _magicHomeSink.add(MagicHome(
      internetAddress: InternetAddress(rawMagicHome[0]),
      rawMac: rawMagicHome[1],
      model: rawMagicHome[2],
    ));
  }

  void stopSearch() => _datagramSubscription.cancel();

  Future<bool> connectTo(MagicHome device) async =>
      magicHomeService.connectWith(device.internetAddress);

  void setColor(MagicHome device, LedColor color) async {
    final message = [
      color.persist ? 0x31 : 0x41,
      color.red,
      color.green,
      color.blue,
      0x00,
      0x00,
      0x0F,
    ];

    await magicHomeService.send(message, device.internetAddress);
  }

  void togglePower(MagicHome device, {bool turnOn = true}) {
    magicHomeService.send(
      turnOn ? _messageOn : _messageOff,
      device.internetAddress,
    );
  }

  void dispose() {
    magicHomeService.dispose();
    _datagramSubscription?.cancel();
  }
}
