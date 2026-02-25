import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:test_app/src/serial_executor.dart';

part 'base_state.dart';

abstract base class BaseController<T extends BaseState> with ChangeNotifier {
  final StreamController<T> _stateController = StreamController<T>.broadcast();
  @protected
  final SerialExecutor serialExecutor = SerialExecutor();
  final String name;
  T _state;

  BaseController({required this.name, required T state}) : _state = state;

  T get state => _state;
  Stream<T> get stateStream => _stateController.stream;
  bool get isClosed => _stateController.isClosed;

  @protected
  void setState(T newState) {
    if (isClosed || identical(newState, _state)) return;

    final previousState = _state;
    _state = newState;
    _stateController.add(newState);
    notifyListeners();
  }

  @protected
  void onError(Object error, [StackTrace? stackTrace]) {
    // setState(
    //   BaseState.failed(
    //         message: 'Error occured',
    //         error: error,
    //         stackTrace: stackTrace,
    //       )
    //       as T,
    // );
  }

  @protected
  Future<R?> safeExecute<R>(
    Future<R> Function() action, {
    String? errorMessage,
    bool setFailedState = true,
  }) async {
    try {
      return await action();
    } catch (error, stackTrace) {
      // NOTE: Here can be logger
      if (setFailedState && !isClosed) {
        onError(error, stackTrace);
      }
      return null;
    }
  }

  @override
  void dispose() {
    _stateController.close();
    super.dispose();
  }
}
