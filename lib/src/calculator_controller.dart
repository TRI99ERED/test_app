import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:test_app/src/base_controller.dart';

class DivisionByZeroException implements Exception {
  final String message;

  DivisionByZeroException([this.message = 'Can\'t divide by 0']);

  @override
  String toString() => 'DivisionByZeroException: $message';
}

class SqrtNegativeNumberException implements Exception {
  final String message;

  SqrtNegativeNumberException([this.message = 'Can\'t sqrt negative number']);

  @override
  String toString() => 'SqrtNegativeNumberException: $message';
}

sealed class CalculatorState extends BaseState {
  final String memory;
  final String result;
  final bool isReadOnly;

  const CalculatorState({
    required super.message,
    required this.memory,
    required this.result,
    required this.isReadOnly,
  });

  const factory CalculatorState.idle({
    required String memory,
    required String result,
    required bool isReadOnly,
    required String message,
  }) = CalculatorStateIdle;
  const factory CalculatorState.processing({
    required String memory,
    required String result,
    required bool isReadOnly,
    required String message,
  }) = CalculatorStateProcessing;
  const factory CalculatorState.failed({
    required String memory,
    required String result,
    required bool isReadOnly,
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) = CalculatorStateFailed;

  @override
  bool get isIdle => this is CalculatorStateIdle;

  @override
  bool get isFailed => this is CalculatorStateFailed;

  @override
  bool get isProcessing => this is CalculatorStateProcessing;

  @override
  Object? get error => switch (this) {
    CalculatorStateFailed(:final error) => error,
    _ => null,
  };

  @override
  T map<T>({
    required T Function(BaseState) idle,
    required T Function(BaseState) processing,
    required T Function(BaseState) failed,
    T Function(BaseState)? orElse,
  }) => switch (this) {
    CalculatorStateIdle() => idle(this),
    CalculatorStateProcessing() => processing(this),
    CalculatorStateFailed() => failed(this),
  };

  CalculatorState copyWith({
    String? memory,
    String? result,
    bool? isReadOnly,
    String? message,
  });
}

final class CalculatorStateIdle extends CalculatorState {
  const CalculatorStateIdle({
    required super.memory,
    required super.result,
    required super.isReadOnly,
    required super.message,
  });

  @override
  String get type => 'idle';

  @override
  CalculatorStateIdle copyWith({
    String? memory,
    String? result,
    bool? isReadOnly,
    String? message,
  }) {
    return CalculatorStateIdle(
      memory: memory ?? this.memory,
      result: result ?? this.result,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CalculatorStateIdle &&
            runtimeType == other.runtimeType &&
            message == other.message &&
            memory == other.memory &&
            result == other.result &&
            isReadOnly == other.isReadOnly;
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, memory, result, isReadOnly);
}

final class CalculatorStateProcessing extends CalculatorState {
  const CalculatorStateProcessing({
    required super.memory,
    required super.result,
    required super.isReadOnly,
    required super.message,
  });

  @override
  String get type => 'action';

  @override
  CalculatorStateProcessing copyWith({
    String? memory,
    String? result,
    bool? isReadOnly,
    String? message,
  }) {
    return CalculatorStateProcessing(
      memory: memory ?? this.memory,
      result: result ?? this.result,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CalculatorStateIdle &&
            runtimeType == other.runtimeType &&
            message == other.message &&
            memory == other.memory &&
            result == other.result &&
            isReadOnly == other.isReadOnly;
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, memory, result, isReadOnly);
}

final class CalculatorStateFailed extends CalculatorState {
  @override
  final Object? error;
  final StackTrace? stackTrace;

  const CalculatorStateFailed({
    required super.memory,
    required super.result,
    required super.isReadOnly,
    required super.message,
    this.error,
    this.stackTrace,
  });

  @override
  String get type => 'failed';

  @override
  CalculatorStateFailed copyWith({
    String? memory,
    String? result,
    bool? isReadOnly,
    String? message,
    Object? error,
    StackTrace? stackTrace,
  }) {
    return CalculatorStateFailed(
      memory: memory ?? this.memory,
      result: result ?? this.result,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      message: message ?? this.message,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CalculatorStateIdle &&
            runtimeType == other.runtimeType &&
            message == other.message &&
            memory == other.memory &&
            result == other.result &&
            isReadOnly == other.isReadOnly &&
            error == other.error;
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, memory, result, isReadOnly, error);
}

final class CalculatorController extends BaseController<CalculatorState> {
  CalculatorController()
    : super(
        state: const CalculatorState.idle(
          memory: '',
          result: '0',
          isReadOnly: false,
          message: 'initialised',
        ),
        name: 'CalculatorController',
      ) {
    // NOTE: You can make actions here
  }

  Future<void> percent() async => await serialExecutor.synchronized(() async {
    try {
      if (state.isReadOnly) {
        return;
      }
      setState(
        state.copyWith(
          memory: '${state.result}%',
          result: '0',
          isReadOnly: false,
          message: 'Adding percent',
        ),
      );
    } catch (error, stackTrace) {
      setState(
        CalculatorState.failed(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: 'Add percent error',
          error: error,
          stackTrace: stackTrace,
        ),
      );
      onError(error, stackTrace);
    } finally {
      setState(
        CalculatorState.idle(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: state.message,
        ),
      );
    }
  });

  Future<void> ce() async => await serialExecutor.synchronized(() async {
    try {
      setState(
        state.copyWith(
          result: '0',
          isReadOnly: false,
          message: 'Clearing entry',
        ),
      );
    } catch (error, stackTrace) {
      setState(
        CalculatorState.failed(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: 'Clearing entry error',
          error: error,
          stackTrace: stackTrace,
        ),
      );
      onError(error, stackTrace);
    } finally {
      setState(
        CalculatorState.idle(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: state.message,
        ),
      );
    }
  });

  Future<void> c() async => await serialExecutor.synchronized(() async {
    try {
      setState(
        state.copyWith(
          memory: '',
          result: '0',
          isReadOnly: false,
          message: 'Clearing all',
        ),
      );
    } catch (error, stackTrace) {
      setState(
        CalculatorState.failed(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: 'Clearing all error',
          error: error,
          stackTrace: stackTrace,
        ),
      );
      onError(error, stackTrace);
    } finally {
      setState(
        CalculatorState.idle(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: state.message,
        ),
      );
    }
  });

  Future<void> backspace() async => await serialExecutor.synchronized(() async {
    try {
      if (state.isReadOnly) {
        return;
      }

      var newLength = state.result.length - 1;

      setState(
        state.copyWith(
          result: newLength == 0 ? '0' : state.result.substring(0, newLength),
          message: 'Reducing entry',
        ),
      );
    } catch (error, stackTrace) {
      setState(
        CalculatorState.failed(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: 'Reducing entry error',
          error: error,
          stackTrace: stackTrace,
        ),
      );
      onError(error, stackTrace);
    } finally {
      setState(
        CalculatorState.idle(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: state.message,
        ),
      );
    }
  });

  Future<void> reciprocal({void Function(Object error)? onError}) async =>
      await serialExecutor.synchronized(() async {
        try {
          if (state.result == '0') {
            setState(
              CalculatorState.failed(
                memory: state.memory,
                result: 'Can\'t divide by zero',
                message: 'Reciprocal error: division by zero',
                isReadOnly: true,
              ),
            );
          } else {
            setState(
              state.copyWith(
                memory: '1/(${state.result})=',
                result: (1 / double.parse(state.result)).toString(),
                isReadOnly: true,
                message: 'Reciprocal calculated',
              ),
            );
          }
        } catch (error, stackTrace) {
          setState(
            CalculatorState.failed(
              memory: state.memory,
              result: state.result,
              isReadOnly: state.isReadOnly,
              message: 'Reciprocal error',
              error: error,
              stackTrace: stackTrace,
            ),
          );
          onError?.call(error);
          this.onError(error, stackTrace);
        }
      });

  Future<void> sqr() async => await serialExecutor.synchronized(() async {
    try {
      var value = double.parse(state.result);
      setState(
        state.copyWith(
          memory: '${state.result}²=',
          result: (value * value).toString(),
          isReadOnly: true,
          message: 'Square calculated',
        ),
      );
    } catch (error, stackTrace) {
      setState(
        CalculatorState.failed(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: 'Square error',
          error: error,
          stackTrace: stackTrace,
        ),
      );
      onError(error, stackTrace);
    } finally {
      setState(
        CalculatorState.idle(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: state.message,
        ),
      );
    }
  });

  Future<void> sqrt() async => await serialExecutor.synchronized(() async {
    try {
      if (state.result.startsWith('-')) {
        setState(
          CalculatorState.failed(
            memory: state.memory,
            result: 'Can\'t sqrt negative number',
            isReadOnly: true,
            message: 'Square root error',
          ),
        );
      } else {
        setState(
          state.copyWith(
            memory: '√${state.result}=',
            result: math.sqrt(double.parse(state.result)).toString(),
            isReadOnly: true,
            message: 'Square root calculated',
          ),
        );
      }
    } catch (error, stackTrace) {
      setState(
        CalculatorState.failed(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: 'Square root error',
          error: error,
          stackTrace: stackTrace,
        ),
      );
      onError(error, stackTrace);
    }
  });

  Future<void> div() async => await serialExecutor.synchronized(() async {
    try {
      setState(
        state.copyWith(
          memory: '${state.result}÷',
          result: '0',
          isReadOnly: false,
          message: 'Division operation initiated',
        ),
      );
    } catch (error, stackTrace) {
      setState(
        CalculatorState.failed(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: 'Division error',
          error: error,
          stackTrace: stackTrace,
        ),
      );
      onError(error, stackTrace);
    } finally {
      setState(
        CalculatorState.idle(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: state.message,
        ),
      );
    }
  });

  Future<void> mul() async => await serialExecutor.synchronized(() async {
    try {
      setState(
        state.copyWith(
          memory: '${state.result}×',
          result: '0',
          isReadOnly: false,
          message: 'Multiplication operation initiated',
        ),
      );
    } catch (error, stackTrace) {
      setState(
        CalculatorState.failed(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: 'Multiplication error',
          error: error,
          stackTrace: stackTrace,
        ),
      );
      onError(error, stackTrace);
    } finally {
      setState(
        CalculatorState.idle(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: state.message,
        ),
      );
    }
  });

  Future<void> sub() async => await serialExecutor.synchronized(() async {
    try {
      setState(
        state.copyWith(
          memory: '${state.result}−',
          result: '0',
          isReadOnly: false,
          message: 'Subtraction operation initiated',
        ),
      );
    } catch (error, stackTrace) {
      setState(
        CalculatorState.failed(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: 'Subtraction error',
          error: error,
          stackTrace: stackTrace,
        ),
      );
      onError(error, stackTrace);
    } finally {
      setState(
        CalculatorState.idle(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: state.message,
        ),
      );
    }
  });

  Future<void> add() async => await serialExecutor.synchronized(() async {
    try {
      setState(
        state.copyWith(
          memory: '${state.result}+',
          result: '0',
          isReadOnly: false,
          message: 'Addition operation initiated',
        ),
      );
    } catch (error, stackTrace) {
      setState(
        CalculatorState.failed(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: 'Addition error',
          error: error,
          stackTrace: stackTrace,
        ),
      );
      onError(error, stackTrace);
    } finally {
      setState(
        CalculatorState.idle(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: state.message,
        ),
      );
    }
  });

  Future<void> sign() async => await serialExecutor.synchronized(() async {
    try {
      if (state.isReadOnly) {
        return;
      }

      setState(
        state.copyWith(result: '-${state.result}', message: 'Sign changed'),
      );
    } catch (error, stackTrace) {
      setState(
        CalculatorState.failed(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: 'Sign change error',
          error: error,
          stackTrace: stackTrace,
        ),
      );
      onError(error, stackTrace);
    } finally {
      setState(
        CalculatorState.idle(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: state.message,
        ),
      );
    }
  });

  Future<void> point() async => await serialExecutor.synchronized(() async {
    try {
      if (state.isReadOnly) {
        return;
      }

      if (state.result ==
          double.parse(state.result).toInt().toDouble().toString()) {
        setState(
          state.copyWith(
            result: '${state.result}.',
            message: 'Adding decimal point',
          ),
        );
      }
    } catch (error, stackTrace) {
      setState(
        CalculatorState.failed(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: 'Sign change error',
          error: error,
          stackTrace: stackTrace,
        ),
      );
      onError(error, stackTrace);
    } finally {
      setState(
        CalculatorState.idle(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: state.message,
        ),
      );
    }
  });

  Future<void> equals() async => await serialExecutor.synchronized(() async {
    try {
      if (state.memory.isEmpty) {
        return;
      }

      var numberLength = state.memory.length - 1;
      var a = double.parse(
        state.memory.characters.take(numberLength).toString(),
      );
      var sign = state.memory.characters.last;
      var b = double.parse(state.result);

      setState(
        state.copyWith(
          result: switch (sign) {
            '+' => (a + b).toString(),
            '−' => (a - b).toString(),
            '×' => (a * b).toString(),
            '÷' => b == 0 ? 'Can\'t divide by zero' : (a / b).toString(),
            _ => state.result,
          },
          memory: (b >= 0) ? '${state.memory}$b=' : '${state.memory}($b)=',
          isReadOnly: true,
          message: 'Calculation performed',
        ),
      );
    } catch (error, stackTrace) {
      setState(
        CalculatorState.failed(
          memory: state.memory,
          result: state.result,
          isReadOnly: state.isReadOnly,
          message: 'Calculation error',
          error: error,
          stackTrace: stackTrace,
        ),
      );
      onError(error, stackTrace);
    }
  });

  Future<void> addNumber(int number) async =>
      await serialExecutor.synchronized(() async {
        try {
          if (state.isReadOnly) {
            return;
          }

          if (state.result == '0') {
            setState(
              state.copyWith(
                result: number.toString(),
                message: 'Adding number $number',
              ),
            );
          } else {
            setState(
              state.copyWith(
                result: '${state.result}$number',
                message: 'Adding number $number',
              ),
            );
          }
        } catch (error, stackTrace) {
          setState(
            CalculatorState.failed(
              memory: state.memory,
              result: state.result,
              isReadOnly: state.isReadOnly,
              message: 'Add number error',
              error: error,
              stackTrace: stackTrace,
            ),
          );
          onError(error, stackTrace);
        }
      });

  @override
  void dispose() {
    super.dispose();
  }
}
