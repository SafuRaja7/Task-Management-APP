part of 'task_cubit.dart';

class TaskFetchState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final List<TaskModel?>? data;
  final String? message;
  const TaskFetchState({
    this.data,
    this.message,
  });

  @override
  List<Object> get props => [];
}

class TaskFetchLoading extends TaskFetchState {}

class TaskFetchSuccess extends TaskFetchState {
  const TaskFetchSuccess({List<TaskModel>? data}) : super(data: data);
}

class TaskFetchFailed extends TaskFetchState {
  const TaskFetchFailed(String? message) : super(message: message);
}

// add

class TaskAddState extends Equatable {
  static bool match(a, b) => a.add != b.add;

  final String? message;
  const TaskAddState({
    this.message,
  });

  @override
  List<Object> get props => [
        message!,
      ];
}

class TaskAddLoading extends TaskAddState {}

class TaskAddSuccess extends TaskAddState {}

class TaskAddFailed extends TaskAddState {
  const TaskAddFailed({super.message});
}

// update
class OrderUpdateState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final String? message;

  const OrderUpdateState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

class OrderUpdateDefault extends OrderUpdateState {}

class OrderUpdateLoading extends OrderUpdateState {
  const OrderUpdateLoading() : super();
}

class OrderUpdateSuccess extends OrderUpdateState {
  const OrderUpdateSuccess() : super();
}

class OrderUpdateFailed extends OrderUpdateState {
  const OrderUpdateFailed({super.message});
}

class TaskState extends Equatable {
  final TaskAddState? add;
  final TaskFetchState? fetch;
  final OrderUpdateState? update;
  const TaskState({
    this.add,
    this.fetch,
    this.update,
  });

  @override
  List<Object?> get props => [
        fetch,
        add,
        update,
      ];

  TaskState copyWith({
    TaskFetchState? fetch,
    TaskAddState? addMemory,
    OrderUpdateState? update,
  }) {
    return TaskState(
      fetch: fetch ?? this.fetch,
      add: add ?? add,
    );
  }
}

class TaskStateDefault extends TaskState {
  const TaskStateDefault()
      : super(
          fetch: const TaskFetchState(),
          add: const TaskAddState(),
          update: const OrderUpdateState(),
        );
}
