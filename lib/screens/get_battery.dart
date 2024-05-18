import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryScreen extends StatefulWidget {
  @override
  _BatteryScreenState createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen> {
  String _batteryLevel = 'Unknown';

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
  }

  static const platform = MethodChannel('BatteryCount');

  // Future<void> _getBatteryLevel() async {
  //   final batteryApi = BatteryApi();
  //   try {
  //     final response = await batteryApi.getBatteryLevel();
  //     setState(() {
  //       _batteryLevel = '${response.batteryLevel}%';
  //     });
  //   } catch (e) {
  //     print("error is $e");
  //     setState(() {
  //       _batteryLevel = 'Failed to get battery level';
  //     });
  //   }
  // }

  Future<void> _getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod(
        'Battery',
      );
      setState(() {
        print("Battery $result");
        _batteryLevel = result.toString();
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to increment counter: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Battery Level'),
      ),
      body: Center(
        child: Text(
          'Battery Level: $_batteryLevel',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
