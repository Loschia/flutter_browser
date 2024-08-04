import 'package:flutter/material.dart';

import '../flutter_browser.dart';
import 'browser_controller.dart';

class Browser extends StatefulWidget {
  final BrowserController controller;

  const Browser({required this.controller, super.key});

  @override
  createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  BrowserController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebRenderer(controller: widget.controller),
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    // collect data
    return 'Controller: ${controller.toString()}';
  }
}
