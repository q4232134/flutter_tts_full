import 'dart:async';
import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/services.dart';

class Flutterttsfull {
  static const MethodChannel _channel = const MethodChannel('flutterttsfull');
  void Function(String tag, String content, int index) onPlaying;
  void Function(String tag) onCancel;
  void Function(String tag) onNext;
  void Function(String tag) onPause;
  void Function(String tag) onStart;
  void Function(String tag) onFinish;

  Flutterttsfull() {
    _channel.setMethodCallHandler(platformCallHandler);
  }

  Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<dynamic> proper(String tile, String content, int his) async {
    await _channel.invokeMethod('proper',
        <String, dynamic>{"title": tile, "content": content, "history": his});
  }

  Future<dynamic> start() async {
    await _channel.invokeMethod('start');
  }

  Future<dynamic> stop() async {
    await _channel.invokeMethod('stop');
  }

  Future<bool> isPlaying() async {
    return await _channel.invokeMethod('isPlaying');
  }

  Future platformCallHandler(MethodCall call) async {
    switch (call.method) {
      case "onPlaying":
        onPlaying(call.arguments["tag"], call.arguments["content"],
            call.arguments["index"]);
        break;
      case "onCancel":
        onCancel(call.arguments["tag"]);
        break;
      case "onNext":
        onNext(call.arguments["tag"]);
        break;
      case "onPause":
        onPause(call.arguments["tag"]);
        break;
      case "onStart":
        onStart(call.arguments["tag"]);
        break;
      case "onFinish":
        onFinish(call.arguments["tag"]);
        break;
      default:
        print('Unknowm method ${call.method}');
    }
  }
}
