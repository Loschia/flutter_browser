import 'package:flutter/material.dart';

import '../browser_controller.dart';

class WebRenderer extends StatelessWidget {
  final BrowserController controller;

  const WebRenderer({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 100,
      width: 200,
    );
  }
}
