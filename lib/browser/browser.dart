import '../index.dart';

class Browser extends StatefulWidget {
  final BrowserController controller;

  const Browser({required this.controller, super.key});

  @override
  createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebRenderer(controller: widget.controller),
    );
  }
}
