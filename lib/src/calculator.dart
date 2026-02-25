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
  // String _memory = '';
  // String _result = '0';
  // bool _isReadOnly = false;
  // bool _isError = false;

  // void _percent() {
  //   setState(() {
  //     _memory = '$_result%';
  //     _result = '0';
  //     _isReadOnly = false;
  //   });
  // }

  // void _ce() {
  //   setState(() {
  //     _result = '0';
  //     _isReadOnly = false;
  //   });
  // }

  // void _c() {
  //   setState(() {
  //     _memory = '';
  //     _result = '0';
  //     _isReadOnly = false;
  //     _isError = false;
  //   });
  // }

  // void _backspace() {
  //   setState(() {
  //     if (_isReadOnly) {
  //       return;
  //     }

  //     var newLength = _result.length - 1;

  //     if (newLength == 0) {
  //       _result = '0';
  //     } else {
  //       _result = _result.characters.take(newLength).toString();
  //     }
  //   });
  // }

  // void _reciprocal() {
  //   setState(() {
  //     _memory = '1/($_result)=';
  //     _isReadOnly = true;
  //     if (_result == '0') {
  //       _result = 'Can\'t divide by 0';
  //       _isError = true;
  //     } else {
  //       _result = (1 / double.parse(_result)).toString();
  //     }
  //   });
  // }

  // void _sqr() {
  //   setState(() {
  //     _memory = '$_result²=';
  //     _isReadOnly = true;
  //     var result = double.tryParse(_result)!;
  //     _result = (result * result).toString();
  //   });
  // }

  // void _sqrt() {
  //   setState(() {
  //     _memory = '√$_result=';
  //     _isReadOnly = true;
  //     if (_result.characters.first == '-') {
  //       _result = 'Can\'t sqrt negative number';
  //       _isError = true;
  //     } else {
  //       var result = double.tryParse(_result)!;
  //       _result = sqrt(result).toString();
  //     }
  //   });
  // }

  // void _div() {
  //   setState(() {
  //     _memory = '$_result÷';
  //     _result = '0';
  //     _isReadOnly = false;
  //   });
  // }

  // void _seven() {
  //   setState(() {
  //     if (_isReadOnly) {
  //       return;
  //     }

  //     if (_result == '0') {
  //       _result = '7';
  //     } else {
  //       _result = '${_result}7';
  //     }
  //   });
  // }

  // void _eight() {
  //   setState(() {
  //     if (_isReadOnly) {
  //       return;
  //     }

  //     if (_result == '0') {
  //       _result = '8';
  //     } else {
  //       _result = '${_result}8';
  //     }
  //   });
  // }

  // void _nine() {
  //   setState(() {
  //     if (_isReadOnly) {
  //       return;
  //     }

  //     if (_result == '0') {
  //       _result = '9';
  //     } else {
  //       _result = '${_result}9';
  //     }
  //   });
  // }

  // void _mul() {
  //   setState(() {
  //     _memory = '$_result×';
  //     _result = '0';
  //     _isReadOnly = false;
  //   });
  // }

  // void _four() {
  //   setState(() {
  //     if (_isReadOnly) {
  //       return;
  //     }

  //     if (_result == '0') {
  //       _result = '4';
  //     } else {
  //       _result = '${_result}4';
  //     }
  //   });
  // }

  // void _five() {
  //   setState(() {
  //     if (_isReadOnly) {
  //       return;
  //     }

  //     if (_result == '0') {
  //       _result = '5';
  //     } else {
  //       _result = '${_result}5';
  //     }
  //   });
  // }

  // void _six() {
  //   setState(() {
  //     if (_isReadOnly) {
  //       return;
  //     }

  //     if (_result == '0') {
  //       _result = '6';
  //     } else {
  //       _result = '${_result}6';
  //     }
  //   });
  // }

  // void _sub() {
  //   setState(() {
  //     _memory = '$_result−';
  //     _result = '0';
  //     _isReadOnly = false;
  //   });
  // }

  // void _one() {
  //   setState(() {
  //     if (_isReadOnly) {
  //       return;
  //     }

  //     if (_result == '0') {
  //       _result = '1';
  //     } else {
  //       _result = '${_result}1';
  //     }
  //   });
  // }

  // void _two() {
  //   setState(() {
  //     if (_isReadOnly) {
  //       return;
  //     }

  //     if (_result == '0') {
  //       _result = '2';
  //     } else {
  //       _result = '${_result}2';
  //     }
  //   });
  // }

  // void _three() {
  //   setState(() {
  //     if (_isReadOnly) {
  //       return;
  //     }

  //     if (_result == '0') {
  //       _result = '3';
  //     } else {
  //       _result = '${_result}3';
  //     }
  //   });
  // }

  // void _add() {
  //   setState(() {
  //     _memory = '$_result+';
  //     _result = '0';
  //     _isReadOnly = false;
  //   });
  // }

  // void _sign() {
  //   setState(() {
  //     if (_isReadOnly) {
  //       return;
  //     }

  //     _result = '-$_result';
  //   });
  // }

  // void _zero() {
  //   setState(() {
  //     if (_isReadOnly) {
  //       return;
  //     }

  //     if (_result != '0') {
  //       _result = '${_result}0';
  //     }
  //   });
  // }

  // void _point() {
  //   setState(() {
  //     if (_isReadOnly) {
  //       return;
  //     }

  //     if (_result == double.parse(_result).toInt().toDouble().toString()) {
  //       _result = '$_result.';
  //     }
  //   });
  // }

  // void _equals() {
  //   setState(() {
  //     if (_memory.isEmpty) {
  //       return;
  //     }

  //     var numberLength = _memory.length - 1;
  //     var a = double.tryParse(
  //       _memory.characters.take(numberLength).toString(),
  //     )!;
  //     var sign = _memory.characters.last;
  //     var b = double.tryParse(_result)!;

  //     switch (sign) {
  //       case '%':
  //         _result = (a * b * 0.01).toString();
  //         break;
  //       case '÷':
  //         if (_result != '0') {
  //           _result = (a / b).toString();
  //         } else {
  //           _result = 'Can\'t divide by 0';
  //           _isError = true;
  //         }
  //         break;
  //       case '×':
  //         _result = (a * b).toString();
  //         break;
  //       case '−':
  //         _result = (a - b).toString();
  //         break;
  //       case '+':
  //         _result = (a + b).toString();
  //         break;
  //       default:
  //         break;
  //     }

  //     if (b >= 0) {
  //       _memory = '$_memory$b=';
  //     } else {
  //       _memory = '$_memory($b)=';
  //     }
  //     _isReadOnly = true;
  //   });
  // }

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
