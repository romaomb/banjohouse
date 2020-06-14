import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import '../../models/led_color.dart';
import '../../models/magic_home.dart';
import '../../models/magic_home_info.dart';
import '../../services/magic_home_service.dart';
import 'led_repository.dart';

class MagicHomeRepository implements LedRepository {
  final MagicHomeService magicHomeService;

  MagicHomeRepository(this.magicHomeService);

  final _magicHome = StreamController<MagicHome>();
  StreamSink get _magicHomeSink => _magicHome.sink;
  Stream<MagicHome> get magicHome => _magicHome.stream.asBroadcastStream();

  final _magicHomeInfo = StreamController<MagicHomeInfo>();
  StreamSink get _magicHomeInfoSink => _magicHomeInfo.sink;
  Stream<MagicHomeInfo> get magicHomeInfo =>
      _magicHomeInfo.stream.asBroadcastStream();

  StreamSubscription _datagramSubscription;
  StreamSubscription _tcpSubscription;

  void searchForDevices(InternetAddress broadcastAddress) async {
    _datagramSubscription?.cancel();
    _datagramSubscription =
        magicHomeService.datagram.listen(_onDatagramReceived);

    await magicHomeService.startSearch(broadcastAddress);
  }

  void _onDatagramReceived(String datagram) {
    final rawMagicHome = datagram.split(',');
    _magicHomeSink.add(MagicHome(
      internetAddress: InternetAddress(rawMagicHome[0]),
      rawMac: rawMagicHome[1],
      model: rawMagicHome[2],
    ));
  }

  void stopSearch() => _datagramSubscription.cancel();

  Future<bool> connectTo(MagicHome device) async {
    await magicHomeService.connectWith(device.internetAddress);
    _tcpSubscription = magicHomeService.tcpStream.listen(_onTcpMessageReceived);
    magicHomeService.send(messageInfo, device.internetAddress);
    return true;
  }

  void _onTcpMessageReceived(Uint8List message) {
    if (message != null && message.length == messageInfoLength) {
      print(message);
      _magicHomeInfoSink.add(
        MagicHomeInfo(
          color: LedColor(message[6], message[7], message[8]),
          isOn: message[2] == on,
        ),
      );
    }
  }

  void setColor(MagicHome device, LedColor color) {
    final message = [
      color.persist ? persist : temporary,
      color.red,
      color.green,
      color.blue,
      0x00,
      0x00,
      0x0F,
    ];

    magicHomeService.send(message, device.internetAddress);
  }

  void togglePower(MagicHome device, {bool turnOn = true}) {
    magicHomeService.send(
      turnOn ? messageOn : messageOff,
      device.internetAddress,
    );
  }

  void getInfo(MagicHome device) =>
      magicHomeService.send(messageInfo, device.internetAddress);

  void dispose() {
    magicHomeService.dispose();
    _datagramSubscription?.cancel();
    _tcpSubscription?.cancel();
  }
}
