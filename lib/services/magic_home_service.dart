import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class MagicHomeService {
  static const _asciiCodec = AsciiCodec();
  static const _messageDiscovery = 'HF-A11ASSISTHREAD';
  static const _discoveryPort = 48899;
  static const _devicePort = 5577;
  static const _bitwise = 0xFF;

  Socket _tcpSocket;

  RawDatagramSocket _udpSocket;
  Stream<RawSocketEvent> get _udpStream => _udpSocket.asBroadcastStream();
  StreamSubscription _udpSubscription;

  final _datagram = StreamController<String>();
  StreamSink get _datagramSink => _datagram.sink;
  Stream<String> get datagram => _datagram.stream.asBroadcastStream();

  Future<void> startSearch(InternetAddress broadcastAddress) async {
    if (_udpSocket == null) await _bindUdpSocket();

    _udpSubscription?.cancel();
    _udpSubscription =
        await _udpStream.listen((event) => _onRawDatagramReceived());

    print('Sending message');
    final message = _asciiCodec.encode(_messageDiscovery);
    _udpSocket.send(message, broadcastAddress, _discoveryPort);
  }

  void _onRawDatagramReceived() {
    final datagram = _udpSocket.receive();
    print('Received message');
    if (datagram != null) {
      final decodedDatagram = _asciiCodec.decode(datagram.data);
      print('Datagram: $decodedDatagram');
      if (decodedDatagram != null && decodedDatagram != _messageDiscovery) {
        _datagramSink.add(decodedDatagram);
      }
    }
  }

  void _bindUdpSocket() async {
    _udpSocket = await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      _discoveryPort,
    );
    _udpSocket.broadcastEnabled = true;
  }

  void stopSearch() => _udpSubscription.cancel();

  Future<bool> connectWith(InternetAddress address) async {
    if (_tcpSocket != null) return false;
    _tcpSocket = await Socket.connect(address, _devicePort);
    return true;
  }

  void send(List<int> message, InternetAddress address) async {
    final sum = message.reduce((value, element) => value + element);
    final checkSum = sum & _bitwise;

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
