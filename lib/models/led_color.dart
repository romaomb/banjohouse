import 'package:equatable/equatable.dart';

class LedColor extends Equatable {
  const LedColor(
    this.red,
    this.green,
    this.blue, {
    this.persist = true,
  })  : assert(red != null),
        assert(green != null),
        assert(blue != null);

  final bool persist;
  final int red;
  final int green;
  final int blue;

  @override
  List<Object> get props => [red, green, blue, persist];
}
