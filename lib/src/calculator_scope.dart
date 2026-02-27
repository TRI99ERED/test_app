import 'package:flutter/material.dart';
import 'package:calculator/src/calculator_controller.dart';

class CalculatorScope extends InheritedWidget {
  final CalculatorController controller;
  final CalculatorState state;

  const CalculatorScope({
    super.key,
    required this.controller,
    required this.state,
    required super.child,
  });

  static CalculatorScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CalculatorScope>();
  }

  static CalculatorScope of(BuildContext context) {
    final scope = maybeOf(context);
    assert(
      scope != null,
      'No CalculatorScope found in context. Make sure to wrap your widget tree with a CalculatorScope.',
    );
    return scope!;
  }

  @override
  bool updateShouldNotify(CalculatorScope oldWidget) {
    return state != oldWidget.state;
  }
}

extension CalculatorScopeExtension on BuildContext {
  CalculatorState get calculatorState =>
      dependOnInheritedWidgetOfExactType<CalculatorScope>()!.state;
  CalculatorController get calculatorController =>
      dependOnInheritedWidgetOfExactType<CalculatorScope>()!.controller;
}
