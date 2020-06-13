import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class MagicHomeService {
  static const _discoveryPort = 48899;
  static const _discoveryMessage = 'HF-A11ASSISTHREAD';
  static const _asciiCodec = AsciiCodec();
  static const _devicePort = 5577;
  static const _bitwise = 0xFF;

  Socket _tcpSocket;

  Future<String> find(InternetAddress broadcastAddress) async {
    final udpSocket =
        await RawDatagramSocket.bind(InternetAddress.anyIPv4, _discoveryPort)
          ..broadcastEnabled = true;

    Timer(const Duration(seconds: 2), udpSocket.close);

    final message = _asciiCodec.encode(_discoveryMessage);
    udpSocket.send(message, broadcastAddress, _discoveryPort);

    String data;
    await udpSocket.firstWhere((_) {
      final datagram = udpSocket.receive();
      data = _asciiCodec.decode(datagram?.data);
      return datagram != null && data != null && data != _discoveryMessage;
    });

    udpSocket.close();
    return data;
  }

  Future<bool> connect(InternetAddress address) async {
    if (_tcpSocket != null) {
      if (_tcpSocket.address.address != address.address) {
        await _tcpSocket.close();
      } else {
        return true;
      }
    }

    _tcpSocket = await Socket.connect(address, _devicePort);
    return true;
  }

  Future<void> send(List<int> message, InternetAddress address) async {
    final checkSum =
        message.reduce((value, element) => value + element) & _bitwise;
    _tcpSocket.add(Uint8List.fromList([
      ...message,
      checkSum,
    ]));
  }

  void dispose() {
    _tcpSocket?.close();
  }
}
