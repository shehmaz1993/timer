import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';

import '../logic/bloc/timer_bloc.dart';
import '../logic/bloc/timer_event.dart';
import '../logic/bloc/timer_state.dart';
class TimerApp extends StatelessWidget {
 // const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(title: const Text('Timer')),
      body: BlocProvider(
        create: (_) => TimerBloc(),
        child: TimerPage(),
      ),
    );
  }
}


class TimerPage extends StatelessWidget {
 // const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Timer with Headshot and Screenshot'),centerTitle: true,),
      body: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          return Screenshot(
            controller: context.read<TimerBloc>().screenshotController,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.formattedDuration,
                    style: TextStyle(fontSize: 48.0),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.read<TimerBloc>().add(StartTimerAndCapture()),
                    child: Text('Start'),
                  ),
                  SizedBox(height: 20),
                  if (state.headshots.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.headshots.length,
                        itemBuilder: (context, index) {
                          return Image.file(state.headshots[index]);
                        },
                      ),
                    ),
                  if (state.screenshots.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.screenshots.length,
                        itemBuilder: (context, index) {
                          return Image.file(state.screenshots[index]);
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}