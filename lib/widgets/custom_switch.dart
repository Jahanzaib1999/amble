// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitch {
  static Widget customSwitch(
      {required bool value,
      required Function(bool) onToggle,
      required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: FlutterSwitch(
        value: value,
        onToggle: onToggle,
        height: 25,
        width: 50,
        padding: 1,
        activeColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
