import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class MagicHome extends Equatable {
  const MagicHome({
    @required this.internetAddress,
    @required this.mac,
    @required this.model,
  })  : assert(mac != null),
        assert(internetAddress != null),
        assert(model != null);

  final String mac;
  final InternetAddress internetAddress;
  final String model;

  String toString() => '$mac, ${internetAddress.address}, $model';

  @override
  List<Object> get props => [mac, internetAddress, model];
}
