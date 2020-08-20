import 'package:equatable/equatable.dart';

class Wind extends Equatable {
  final double speed;
  final int deg;

  const Wind({this.speed, this.deg});

  @override
  List<Object> get props => [speed, deg];
}
