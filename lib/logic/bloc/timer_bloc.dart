import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'timer_event.dart';
import 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _initialDuration = 0;
  Timer? _timer;
  final ImagePicker _picker = ImagePicker();
  final ScreenshotController screenshotController = ScreenshotController();

  TimerBloc() : super(const TimerState(duration: _initialDuration)) {
    on<StartTimerAndCapture>(_onStartTimerAndCapture);
    on<Tick>(_onTick);
  }

  void _onStartTimerAndCapture(StartTimerAndCapture event, Emitter<TimerState> emit) async {

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(Tick(state.duration + 1));
    });

    
    while (_timer?.isActive ?? false) {

      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        emit(state.copyWith(headshots: [...state.headshots, File(pickedFile.path)]));
      }


      final image = await screenshotController.capture();
      if (image != null) {
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/screenshot_${state.duration}.png').create();
        file.writeAsBytesSync(image);
        emit(state.copyWith(screenshots: [...state.screenshots, file]));
      }


      await Future.delayed(const Duration(seconds: 5));
    }
  }

  void _onTick(Tick event, Emitter<TimerState> emit) {
    emit(state.copyWith(duration: event.duration));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
