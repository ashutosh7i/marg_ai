import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const FGBGDemo(),
    );
  }
}

class FGBGDemo extends StatefulWidget {
  const FGBGDemo({Key? key}) : super(key: key);

  @override
  State<FGBGDemo> createState() => _FGBGDemoState();
}

class _FGBGDemoState extends State<FGBGDemo> {
  List<String> events = [];

  @override
  Widget build(BuildContext context) {
    return FGBGNotifier(
      onEvent: (event) {
        print('App State Changed: $event'); // Print to console
        setState(() {
          events.add('${DateTime.now()}: $event');
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FG/BG Detection Demo'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Switch apps or minimize to test\nBackground/Foreground detection',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  events.clear();
                });
              },
              child: const Text('Clear Logs'),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      events[index].contains('background')
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: events[index].contains('background')
                          ? Colors.red
                          : Colors.green,
                    ),
                    title: Text(events[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
