import 'package:flutter/material.dart';
import 'package:platform_channels_example/screens/event_channels.dart';
import 'package:platform_channels_example/screens/method_channels_example.dart';

class TypeScreen extends StatelessWidget {
  const TypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CounterScreen();
                    },
                  ),
                );
              },
              child: const Text("Method Channels",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const EventScreen();
                    },
                  ),
                );
              },
              child: const Text(
                "Event Channels",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
