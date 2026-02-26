import 'package:flutter/material.dart';
import 'package:test_app/src/calculator_button.dart';
import 'package:test_app/src/calculator_controller.dart';
import 'package:test_app/src/calculator_scope.dart';
import 'package:test_app/src/controller_builder.dart';
import 'package:test_app/src/controller_consumer.dart';
import 'package:test_app/src/controller_listener.dart';

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
    return ControllerListener(
      controller: context.calculatorController,
      listenWhen: (previous, current) {
        if (!previous.isFailed && current.isFailed) {
          return true;
        }
        return false;
      },
      listener: (context, previous, current) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${current.message}')));
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black12,
            toolbarHeight: 100,
            title: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: ControllerBuilder<CalculatorState>(
                controller: context.calculatorController,
                buildWhen: (previous, current) =>
                    previous.result != current.result ||
                    previous.memory != current.memory,
                builder: (context, state) {
                  return Column(
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
                  );
                },
              ),
            ),
          ),
          body: ControllerConsumer<CalculatorState>(
            controller: context.calculatorController,
            listener: (context, previous, current) {},
            listenWhen: (previous, current) =>
                previous.isFailed != current.isFailed,
            buildWhen: (previous, current) => current.isFailed,
            builder: (context, state) {
              return GridView.builder(
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
                      state.isFailed
                          ? null
                          : context.calculatorController.point,
                    '=' =>
                      state.isFailed
                          ? null
                          : context.calculatorController.equals,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
