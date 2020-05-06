import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutterttsfull/flutterttsfull.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Flutterttsfull().platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    _change() async {
      var tts = Flutterttsfull();
      tts.onPlaying = (tag, content, index) => {print('$tag,$content,$index')};
      tts.onStart = (it) => {print(it)};
      tts.onNext = (it) => {print(it)};
      tts.onFinish = (it) => {print(it)};
      print(await tts.isPlaying());
      await tts.proper(
          "123", "更何况怀里的关怀你电话给谁来电话。发给i给华盛顿国会山打发撒旦按分阿。斯蒂芬噶发噶啥大会睡的很阿斯顿", 0);
      tts.start();
      print(await tts.isPlaying());
      setState(() {
        _platformVersion = '123';
      });
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _change,
        ),
      ),
    );
  }
}
