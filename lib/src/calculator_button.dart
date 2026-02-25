import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const CalculatorButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(shape: CircleBorder()),
      child: SizedBox(
        width: 100,
        height: 100,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 64, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
