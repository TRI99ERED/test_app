import 'package:flutter/material.dart';

enum CalculatorButtonType { digit, operator, equals }

class CalculatorButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final CalculatorButtonType type;

  const CalculatorButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fontSize = constraints.maxWidth * 0.3;

        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: switch (type) {
              CalculatorButtonType.digit => Colors.white24,
              CalculatorButtonType.operator => Colors.white10,
              CalculatorButtonType.equals => Colors.white60,
            },
            foregroundColor: switch (type) {
              CalculatorButtonType.digit => Colors.white,
              CalculatorButtonType.operator => Colors.white70,
              CalculatorButtonType.equals => Colors.black,
            },
            textStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Center(child: Text(text, textAlign: TextAlign.center)),
        );
      },
    );
  }
}
