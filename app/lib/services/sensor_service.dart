import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

class SensorService {
  StreamSubscription? _accelerometerSub;
  List<double> _steps = [];

  void startPassiveCollection() {
    _accelerometerSub = accelerometerEventStream.listen((event) {
      if (event.y > 2.0) {
        _steps.add(DateTime.now().millisecondsSinceEpoch.toDouble());
        _steps.removeWhere((t) => DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(t.toInt())).inHours > 24);
      }
    });
  }

  int get dailySteps => _steps.length;

  void stop() {
    _accelerometerSub?.cancel();
  }
}