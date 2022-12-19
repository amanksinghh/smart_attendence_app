import 'dart:async';
import 'package:flutter/material.dart';

class CountUpTimer extends StatefulWidget {
  const CountUpTimer({Key? key}) : super(key: key);

  @override
  State<CountUpTimer> createState() => _CountUpTimerState();
}

class _CountUpTimerState extends State<CountUpTimer> {

  late DateTime _lastButtonPress;
  late String _pressDuration;
  late Timer _ticker;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_pressDuration),
            MaterialButton(
              child: Text("Press me"),
              onPressed: () {
                _lastButtonPress = DateTime.now();
                _updateTimer();
              },
            )
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
   // final lastPressString = sharedPreferences.getString("lastButtonPress");
    _lastButtonPress = DateTime.now();
    _updateTimer();
    _ticker = Timer.periodic(Duration(seconds:1),(_)=>_updateTimer());
  }


  @override
  void dispose() {
    _ticker.cancel();
    super.dispose();
  }

  void _updateTimer() {
    final duration = DateTime.now().difference(_lastButtonPress);
    final newDuration = _formatDuration(duration);
    setState(() {
      _pressDuration = newDuration;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
