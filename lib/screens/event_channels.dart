import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  int count = 0;

  static const _eventChannelCustom = EventChannel('eventChannelTimer');

  // Create a method to get the timerValue stream.
  static Stream<int> get timerValue {
    return _eventChannelCustom.receiveBroadcastStream().map(
          (dynamic event) => event as int,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Event Channel Counter'),
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
                '$count',
                style: const TextStyle(fontSize: 36.0),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            timerValue.listen((event) {
              if (mounted) {
                setState(() {
                  count = event;
                });
              }
            });
          },
          icon: const Icon(Icons.start),
          label: const Text('Start Event'),
          backgroundColor: Colors.blue,
        ));
  }
}
