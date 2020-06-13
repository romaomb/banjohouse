import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class MagicHomeService {
  static const _asciiCodec = AsciiCodec();
  static const messageDiscovery = 'HF-A11ASSISTHREAD';
  static const discoveryPort = 48899;
  static const devicePort = 5577;
  static const bitwise = 0xFF;

  Socket _tcpSocket;

  RawDatagramSocket _udpSocket;
  Stream<RawSocketEvent> get _udpStream => _udpSocket.asBroadcastStream();
  StreamSubscription _udpSubscription;

  final _datagram = StreamController<String>();
  StreamSink get _datagramSink => _datagram.sink;
  Stream<String> get datagram => _datagram.stream.asBroadcastStream();

  void startSearch(InternetAddress broadcastAddress) async {
    if (_udpSocket == null) await _bindUdpSocket();

    final message = _asciiCodec.encode(messageDiscovery);
    _udpSocket.send(message, broadcastAddress, discoveryPort);

    _udpSubscription?.cancel();
    _udpSubscription = _udpStream.listen((event) {
      final datagram = _udpSocket.receive();
      if (datagram != null) {
        final decodedDatagram = _asciiCodec.decode(datagram.data);
        if (decodedDatagram != null && decodedDatagram != messageDiscovery) {
          _datagramSink.add(decodedDatagram);
        }
      }
    });
  }

  void _bindUdpSocket() async {
    _udpSocket = await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      discoveryPort,
    );
    _udpSocket.broadcastEnabled = true;
  }

  void stopSearch() => _udpSubscription.cancel();

  Future<bool> connectWith(InternetAddress address) async {
    if (_tcpSocket != null) return false;
    _tcpSocket = await Socket.connect(address, devicePort);
    return true;
  }

  void send(List<int> message, InternetAddress address) async {
    final sum = message.reduce((value, element) => value + element);
    final checkSum = sum & bitwise;

    _tcpSocket.add(Uint8List.fromList([
      ...message,
      checkSum,
    ]));
  }

  void dispose() {
    _udpSubscription?.cancel();
    _tcpSocket?.close();
    _udpSocket?.close();
  }
}
