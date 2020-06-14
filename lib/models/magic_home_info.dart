import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'led_color.dart';

class MagicHomeInfo extends Equatable {
  final bool isOn;
  final LedColor color;

  const MagicHomeInfo({
    @required this.color,
    @required this.isOn,
  }) : assert(isOn != null);

  @override
  // TODO: implement props
  List<Object> get props => [isOn, color];
}
