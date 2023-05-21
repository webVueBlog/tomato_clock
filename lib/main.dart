import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '🍅番茄钟',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const DEFAULT_COUNT_DOWN = Duration.secondsPerMinute * 25;
  int countDown = 0;
  late Timer timer = Timer.periodic(Duration.zero, (_) {});

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startCountDown() {
    if (timer != null) timer.cancel();
    countDown = DEFAULT_COUNT_DOWN;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countDown--;
      });
      debugPrint(countDown.toString());
      if (countDown == 0) {
        timer.cancel();
        showDialog(context: context, builder: (context) {
          return const AlertDialog(
            content: Text("成功获得一个🍅，请注意休息！"),
          );
        });
      }
    });
  }

  String padDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  String parseText() {
    final minutes = (countDown / 60).floor();
    final seconds = countDown % 60;
    return '${padDigits(minutes)}:${padDigits(seconds)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          parseText(),
          style: const TextStyle(
              fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: startCountDown,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
