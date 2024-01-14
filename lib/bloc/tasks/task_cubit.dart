import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/bloc/tasks/repo.dart';
import 'package:task_management/models/task_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  static TaskCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<TaskCubit>(context, listen: listen);
  TaskCubit() : super(const TaskStateDefault());

  final repo = TaskRepo();

  Future<void> fetch() async {
    emit(
      state.copyWith(
        fetch: TaskFetchLoading(),
      ),
    );
    try {
      repo.fetch().listen((event) {
        final raw = event.data() ?? {'task': []};
        List data = raw['task'] ?? [];
        List<TaskModel> exp = List.generate(
          data.length,
          (i) => TaskModel.fromMap(
            data[i],
          ),
        );
        emit(
          state.copyWith(
            fetch: TaskFetchSuccess(data: exp),
          ),
        );
      }, onError: (e) {
        emit(
          state.copyWith(
            fetch: TaskFetchFailed(e.toString()),
          ),
        );
      });
    } catch (e) {
      emit(
        state.copyWith(
          fetch: TaskFetchFailed(e.toString()),
        ),
      );
    }
  }

  Future<void> add(TaskModel exp) async {
    emit(
      state.copyWith(
        addMemory: TaskAddLoading(),
      ),
    );
    try {
      await repo.add(exp);

      emit(state.copyWith(
        addMemory: TaskAddSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        addMemory: TaskAddFailed(
          message: e.toString(),
        ),
      ));
    }
  }

  Future<void> updateTicket(TaskModel taskModel, int index) async {
    emit(state.copyWith(
      update: const OrderUpdateLoading(),
    ));
    try {
      await repo.update(taskModel, index);

      emit(state.copyWith(
        update: const OrderUpdateSuccess(),
      ));
    } catch (e) {
      emit(state.copyWith(
        update: OrderUpdateFailed(message: e.toString()),
      ));
    }
  }
}
