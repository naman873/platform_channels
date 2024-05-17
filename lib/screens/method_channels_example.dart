import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 0;

  // Method channel
  static const platform = MethodChannel('Calculator');

  void _incrementCounter() async {
    try {
      final int result =
          await platform.invokeMethod('incrementCounter', {'count': counter});
      setState(() {
        counter = result;
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to increment counter: '${e.message}'.");
    }
  }


  void _decrementCounter() async {
    try {
      final int result =
          await platform.invokeMethod('decrementCounter', {'count': counter});
      setState(() {
        counter = result;
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to decrement counter: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Method Channel Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Count:',
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              '$counter',
              style: const TextStyle(fontSize: 36.0),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
