part of 'cubit.dart';

@immutable
class NotificationsState extends Equatable {
  final NotificationBody? data;
  final String? message;

  const NotificationsState({
    this.data,
    this.message,
  });

  @override
  List<Object?> get props => [
        data,
        message,
      ];
}

@immutable
class NotificationsDefault extends NotificationsState {}

@immutable
class NotificationsSendLoading extends NotificationsState {
  const NotificationsSendLoading() : super();
}

@immutable
class NotificationsSendSuccess extends NotificationsState {
  const NotificationsSendSuccess({NotificationBody? data}) : super(data: data);
}

@immutable
class NotificationsSendFailed extends NotificationsState {
  const NotificationsSendFailed({String? message}) : super(message: message);
}
