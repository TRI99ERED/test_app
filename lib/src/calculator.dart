import 'package:flutter/material.dart';
import 'package:test_app/src/calculator_button.dart';
import 'package:test_app/src/calculator_scope.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  static const List<String> buttons = [
    '%',
    'CE',
    'C',
    '⌫',
    '¹/ₓ',
    'x²',
    '√x',
    '÷',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '−',
    '1',
    '2',
    '3',
    '+',
    '⁺/₋',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final state = context.calculatorState;

        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black12,
              toolbarHeight: 100,
              title: SizedBox(
                width: MediaQuery.sizeOf(context).width,
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
                      state.result,
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

            // body: Column(
            //   children: [
            //     Flexible(
            //       child: Row(
            //         children: [
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : context.calculatorController.percent,
            //             text: '%',
            //           ),
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : context.calculatorController.ce,
            //             text: 'CE',
            //           ),
            //           CalculatorButton(
            //             onPressed: context.calculatorController.c,
            //             text: 'C',
            //           ),
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : context.calculatorController.backspace,
            //             text: '⌫',
            //           ),
            //         ],
            //       ),
            //     ),
            //     Flexible(
            //       child: Row(
            //         children: [
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : () async {
            //                     context.calculatorController.reciprocal(
            //                       onError: (error) {
            //                         ScaffoldMessenger.of(context).showSnackBar(
            //                           SnackBar(content: Text('Error: $error')),
            //                         );
            //                       },
            //                     );
            //                   },
            //             text: '¹/ₓ',
            //           ),
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : context.calculatorController.sqr,
            //             text: 'x²',
            //           ),
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : context.calculatorController.sqrt,
            //             text: '√x',
            //           ),
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : context.calculatorController.div,
            //             text: '÷',
            //           ),
            //         ],
            //       ),
            //     ),
            //     Flexible(
            //       child: Row(
            //         children: [
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : () => context.calculatorController.addNumber(7),
            //             text: '7',
            //           ),
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : () => context.calculatorController.addNumber(8),
            //             text: '8',
            //           ),
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : () => context.calculatorController.addNumber(9),
            //             text: '9',
            //           ),
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : context.calculatorController.mul,
            //             text: '×',
            //           ),
            //         ],
            //       ),
            //     ),
            //     Flexible(
            //       child: Row(
            //         children: [
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : () => context.calculatorController.addNumber(4),
            //             text: '4',
            //           ),
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : () => context.calculatorController.addNumber(5),
            //             text: '5',
            //           ),
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : () => context.calculatorController.addNumber(6),
            //             text: '6',
            //           ),
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : context.calculatorController.sub,
            //             text: '−',
            //           ),
            //         ],
            //       ),
            //     ),
            //     Flexible(
            //       child: Row(
            //         children: [
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : () => context.calculatorController.addNumber(1),
            //             text: '1',
            //           ),
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : () => context.calculatorController.addNumber(2),
            //             text: '2',
            //           ),
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : () => context.calculatorController.addNumber(3),
            //             text: '3',
            //           ),
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : context.calculatorController.add,
            //             text: '+',
            //           ),
            //         ],
            //       ),
            //     ),
            //     Flexible(
            //       child: Row(
            //         children: [
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : context.calculatorController.sign,
            //             text: '⁺/₋',
            //           ),
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : () => context.calculatorController.addNumber(0),
            //             text: '0',
            //           ),
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : context.calculatorController.point,
            //             text: '.',
            //           ),
            //           CalculatorButton(
            //             onPressed: state.isFailed
            //                 ? null
            //                 : context.calculatorController.equals,
            //             text: '=',
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            body: GridView.builder(
              padding: const EdgeInsets.all(16),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: 16 / 9,
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                final button = buttons[index];
                final onPressed = switch (button) {
                  '%' =>
                    state.isFailed
                        ? null
                        : context.calculatorController.percent,
                  'CE' => context.calculatorController.ce,
                  'C' => context.calculatorController.c,
                  '⌫' =>
                    state.isFailed
                        ? null
                        : context.calculatorController.backspace,
                  '¹/ₓ' =>
                    state.isFailed
                        ? null
                        : () async {
                            context.calculatorController.reciprocal(
                              onError: (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $error')),
                                );
                              },
                            );
                          },
                  'x²' =>
                    state.isFailed ? null : context.calculatorController.sqr,
                  '√x' =>
                    state.isFailed ? null : context.calculatorController.sqrt,
                  '÷' =>
                    state.isFailed ? null : context.calculatorController.div,
                  '7' =>
                    state.isFailed
                        ? null
                        : () => context.calculatorController.addNumber(7),
                  '8' =>
                    state.isFailed
                        ? null
                        : () => context.calculatorController.addNumber(8),
                  '9' =>
                    state.isFailed
                        ? null
                        : () => context.calculatorController.addNumber(9),
                  '×' =>
                    state.isFailed ? null : context.calculatorController.mul,
                  '4' =>
                    state.isFailed
                        ? null
                        : () => context.calculatorController.addNumber(4),
                  '5' =>
                    state.isFailed
                        ? null
                        : () => context.calculatorController.addNumber(5),
                  '6' =>
                    state.isFailed
                        ? null
                        : () => context.calculatorController.addNumber(6),
                  '−' =>
                    state.isFailed ? null : context.calculatorController.sub,
                  '1' =>
                    state.isFailed
                        ? null
                        : () => context.calculatorController.addNumber(1),
                  '2' =>
                    state.isFailed
                        ? null
                        : () => context.calculatorController.addNumber(2),
                  '3' =>
                    state.isFailed
                        ? null
                        : () => context.calculatorController.addNumber(3),
                  '+' =>
                    state.isFailed ? null : context.calculatorController.add,
                  '⁺/₋' =>
                    state.isFailed ? null : context.calculatorController.sign,
                  '0' =>
                    state.isFailed
                        ? null
                        : () => context.calculatorController.addNumber(0),
                  '.' =>
                    state.isFailed ? null : context.calculatorController.point,
                  '=' =>
                    state.isFailed ? null : context.calculatorController.equals,
                  _ => null,
                };

                final type = switch (button) {
                  '0' ||
                  '1' ||
                  '2' ||
                  '3' ||
                  '4' ||
                  '5' ||
                  '6' ||
                  '7' ||
                  '8' ||
                  '9' => CalculatorButtonType.digit,
                  '+' ||
                  '−' ||
                  '×' ||
                  '÷' ||
                  '%' ||
                  'CE' ||
                  'C' ||
                  '⌫' ||
                  '¹/ₓ' ||
                  'x²' ||
                  '√x' ||
                  '⁺/₋' ||
                  '.' => CalculatorButtonType.operator,
                  _ => CalculatorButtonType.equals,
                };

                return CalculatorButton(
                  onPressed: onPressed,
                  text: button,
                  type: type,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
