import 'package:flutter/material.dart';
import 'package:test_app/src/calculator.dart';
import 'package:test_app/src/calculator_controller.dart';
import 'package:test_app/src/calculator_scope.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final CalculatorController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalculatorController();
    _controller.addListener(_rebuild);
  }

  void _rebuild() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData.dark(),
      home: const CalculatorApp(),
      builder: (context, child) => CalculatorScope(
        controller: _controller,
        state: _controller.state,
        child: child!,
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_rebuild);
    _controller.dispose();
    super.dispose();
  }
}
