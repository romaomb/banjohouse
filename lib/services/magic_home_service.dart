import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../models/magic_home.dart';

class MagicHomeService {
  static const discoveryPort = 48899;
  static const discoveryMessage = 'HF-A11ASSISTHREAD';
  static const discoveryCodec = AsciiCodec();
  static const devicePort = 5577;

  /// TODO: get connected network address
  final destinationNetwork = InternetAddress('192.168.0.255');
  final devices = <MagicHome>[];

  Socket deviceSocket;

  Future<void> scan() async {
    if (devices.isNotEmpty) return;

    final socket =
        await RawDatagramSocket.bind(InternetAddress.anyIPv4, discoveryPort);

    socket.broadcastEnabled = true;

    final socketSubscription = socket.listen((event) {
      final datagram = socket.receive();

      if (datagram != null) {
        final data = discoveryCodec.decode(datagram.data);

        if (data != null && data != discoveryMessage) {
          final rawMagicHome = data.split(',');
          devices.add(MagicHome(
              internetAddress: InternetAddress(rawMagicHome[0]),
              id: rawMagicHome[1],
              model: rawMagicHome[2]));
        }
      }
    });

    final message = discoveryCodec.encode(discoveryMessage);
    socket.send(message, destinationNetwork, discoveryPort);

    await Future<void>.delayed(const Duration(seconds: 3));
    socketSubscription.cancel();

    for (var device in devices) {
      print(device.toString());
    }
  }

  Future<void> send() async {
    if (devices.isEmpty) return;

    print('Forming message');
    final tempMessage = [
      0x31,
      0xFF,
      0x00,
      0x00,
      0x00,
      0x00,
      0x0F,
    ];

    final checkSum =
        tempMessage.reduce((value, element) => value + element) & 0xFF;

    if (deviceSocket == null) {
      deviceSocket =
          await Socket.connect(devices[0].internetAddress, devicePort);
    }

    deviceSocket.add(Uint8List.fromList([
      ...tempMessage,
      checkSum,
    ]));
  }
}
