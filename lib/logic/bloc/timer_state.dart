import 'package:equatable/equatable.dart';
import 'dart:io';

class TimerState extends Equatable {
  final int duration;
  final List<File> headshots;
  final List<File> screenshots;

  const TimerState({
    required this.duration,
    this.headshots = const [],
    this.screenshots = const [],
  });

  @override
  List<Object?> get props => [duration, headshots, screenshots];

  String get formattedDuration {
    final hours = (duration ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((duration ~/ 60) % 60).toString().padLeft(2, '0');
    final seconds = (duration % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  TimerState copyWith({
    int? duration,
    List<File>? headshots,
    List<File>? screenshots,
  }) {
    return TimerState(
      duration: duration ?? this.duration,
      headshots: headshots ?? this.headshots,
      screenshots: screenshots ?? this.screenshots,
    );
  }
}