import 'dart:io';

import 'package:flutter/foundation.dart';

class MagicHome {
  const MagicHome({
    @required this.id,
    @required this.internetAddress,
    @required this.model,
  })  : assert(id != null),
        assert(internetAddress != null),
        assert(model != null);

  final String id;
  final InternetAddress internetAddress;
  final String model;

  String toString() => '$id, ${internetAddress.address}, $model';
}
