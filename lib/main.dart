import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foreground Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Foreground Example Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('example_service');
  String _serverState = 'Did not make the call yet';

  Future<void> _startService() async {
    try {
      final result = await platform.invokeMethod('startExampleService');
      setState(() {
        _serverState = result;
      });
    } on PlatformException catch (e) {
      log("Failed to invoke method: '${e.message}'.");
    }
  }

  Future<void> _stopService() async {
    try {
      final result = await platform.invokeMethod('stopExampleService');
      setState(() {
        _serverState = result;
      });
    } on PlatformException catch (e) {
      log("Failed to invoke method: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(_serverState),
            ElevatedButton(
              child: const Text('Start Service'),
              onPressed: _startService,
            ),
            ElevatedButton(
              child: const Text('Stop Service'),
              onPressed: _stopService,
            ),
          ],
        ),
      ),
    );
  }
}
