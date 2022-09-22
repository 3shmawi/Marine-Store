import 'package:flutter_bloc/flutter_bloc.dart';

class CounterTaskCubit extends Cubit<int> {
  CounterTaskCubit() : super(0);

  void increment() {
    emit(state + 1);
  }

  void decrement() {
    emit(state - 1);
  }

  void restart() {
    emit(0);
  }
}
