import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class MagicHome extends Equatable {
  MagicHome({
    @required this.internetAddress,
    @required String rawMac,
    @required this.model,
  })  : assert(internetAddress != null),
        assert(rawMac != null),
        assert(model != null),
        mac = rawMac.splitMapJoin(
          RegExp(r'..'),
          onMatch: (m) => '${m.group(0)}'
              '${m.end == rawMac[1].length ? '' : ':'}',
        );

  final String mac;
  final InternetAddress internetAddress;
  final String model;

  String toString() => '$mac, ${internetAddress.address}, $model';

  @override
  List<Object> get props => [mac, internetAddress, model];
}
