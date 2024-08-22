import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class StartTimerAndCapture extends TimerEvent {}
class Tick extends TimerEvent {
  final int duration;

  const Tick(this.duration);

  @override
  List<Object> get props => [duration];
}