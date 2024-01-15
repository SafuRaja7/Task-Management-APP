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

//delete
@immutable
class TaskDeleteState extends Equatable {
  static bool match(a, b) => a.delete != b.delete;

  final String? message;

  const TaskDeleteState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class TaskDeleteDefault extends TaskDeleteState {}

@immutable
class TaskDeleteLoading extends TaskDeleteState {
  const TaskDeleteLoading() : super();
}

@immutable
class TaskDeleteSuccess extends TaskDeleteState {
  const TaskDeleteSuccess() : super();
}

@immutable
class TaskDeleteFailed extends TaskDeleteState {
  const TaskDeleteFailed({super.message});
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
  final TaskDeleteState? delete;
  const TaskState({
    this.add,
    this.fetch,
    this.update,
    this.delete,
  });

  @override
  List<Object?> get props => [
        fetch,
        add,
        update,
        delete,
      ];

  TaskState copyWith({
    TaskFetchState? fetch,
    TaskAddState? addMemory,
    OrderUpdateState? update,
    TaskDeleteState? delete,
  }) {
    return TaskState(
      fetch: fetch ?? this.fetch,
      add: add ?? add,
      update: update ?? update,
      delete: delete ?? this.delete,
    );
  }
}

class TaskStateDefault extends TaskState {
  const TaskStateDefault()
      : super(
          fetch: const TaskFetchState(),
          add: const TaskAddState(),
          update: const OrderUpdateState(),
          delete: const TaskDeleteState(),
        );
}
