import 'package:flutter/material.dart';
import 'package:test_app/src/calculator_button.dart';
import 'package:test_app/src/calculator_controller.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData.dark(),
      home: const CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  late final CalculatorController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalculatorController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final state = _controller.state;

        return MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black12,
              toolbarHeight: 100,
              title: SizedBox(
                width: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SelectableText(
                      state.memory,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        overflow: TextOverflow.clip,
                      ),
                      maxLines: 1,
                    ),
                    SelectableText(
                      switch (state) {
                        CalculatorStateFailed() => state.error.toString(),
                        _ => state.result,
                      },
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 64,
                        overflow: TextOverflow.clip,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
            body: Column(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      CalculatorButton(
                        onPressed: state.isFailed ? null : _controller.percent,
                        text: '%',
                      ),
                      CalculatorButton(
                        onPressed: state.isFailed ? null : _controller.ce,
                        text: 'CE',
                      ),
                      CalculatorButton(
                        onPressed: state.isFailed ? null : _controller.c,
                        text: 'C',
                      ),
                      CalculatorButton(
                        onPressed: state.isFailed
                            ? null
                            : _controller.backspace,
                        text: '⌫',
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: [
                      CalculatorButton(
                        onPressed: state.isFailed
                            ? null
                            : _controller.reciprocal,
                        text: '¹/ₓ',
                      ),
                      CalculatorButton(
                        onPressed: state.isFailed ? null : _controller.sqr,
                        text: 'x²',
                      ),
                      CalculatorButton(
                        onPressed: state.isFailed ? null : _controller.sqrt,
                        text: '√x',
                      ),
                      CalculatorButton(
                        onPressed: state.isFailed ? null : _controller.div,
                        text: '÷',
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: [
                      CalculatorButton(
                        onPressed: () =>
                            state.isFailed ? null : _controller.addNumber(7),
                        text: '7',
                      ),
                      CalculatorButton(
                        onPressed: () =>
                            state.isFailed ? null : _controller.addNumber(8),
                        text: '8',
                      ),
                      CalculatorButton(
                        onPressed: () =>
                            state.isFailed ? null : _controller.addNumber(9),
                        text: '9',
                      ),
                      CalculatorButton(
                        onPressed: state.isFailed ? null : _controller.mul,
                        text: '×',
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: [
                      CalculatorButton(
                        onPressed: () =>
                            state.isFailed ? null : _controller.addNumber(4),
                        text: '4',
                      ),
                      CalculatorButton(
                        onPressed: () =>
                            state.isFailed ? null : _controller.addNumber(5),
                        text: '5',
                      ),
                      CalculatorButton(
                        onPressed: () =>
                            state.isFailed ? null : _controller.addNumber(6),
                        text: '6',
                      ),
                      CalculatorButton(
                        onPressed: state.isFailed ? null : _controller.sub,
                        text: '−',
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: [
                      CalculatorButton(
                        onPressed: () =>
                            state.isFailed ? null : _controller.addNumber(1),
                        text: '1',
                      ),
                      CalculatorButton(
                        onPressed: () =>
                            state.isFailed ? null : _controller.addNumber(2),
                        text: '2',
                      ),
                      CalculatorButton(
                        onPressed: () =>
                            state.isFailed ? null : _controller.addNumber(3),
                        text: '3',
                      ),
                      CalculatorButton(
                        onPressed: state.isFailed ? null : _controller.add,
                        text: '+',
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: [
                      CalculatorButton(
                        onPressed: state.isFailed ? null : _controller.sign,
                        text: '⁺/₋',
                      ),
                      CalculatorButton(
                        onPressed: () =>
                            state.isFailed ? null : _controller.addNumber(0),
                        text: '0',
                      ),
                      CalculatorButton(
                        onPressed: state.isFailed ? null : _controller.point,
                        text: '.',
                      ),
                      CalculatorButton(
                        onPressed: state.isFailed ? null : _controller.equals,
                        text: '=',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
