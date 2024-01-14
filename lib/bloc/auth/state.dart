part of 'cubit.dart';

@immutable
class AuthState extends Equatable {
  final AuthData? data;
  final String? message;

  const AuthState({
    this.data,
    this.message,
  });

  @override
  List<Object?> get props => [
        data,
        message,
      ];
}

// fetch
@immutable
class AuthDefault extends AuthState {}

@immutable
class AuthFetchLoading extends AuthState {
  const AuthFetchLoading() : super();
}

@immutable
class AuthFetchSuccess extends AuthState {
  const AuthFetchSuccess({AuthData? data}) : super(data: data);
}

@immutable
class AuthFetchFailed extends AuthState {
  const AuthFetchFailed({String? message}) : super(message: message);
}

// login
@immutable
class AuthLoginLoading extends AuthState {
  const AuthLoginLoading() : super();
}

@immutable
class AuthLoginSuccess extends AuthState {
  const AuthLoginSuccess({AuthData? data}) : super(data: data);
}

@immutable
class AuthLoginFailed extends AuthState {
  const AuthLoginFailed({String? message}) : super(message: message);
}

// signup
@immutable
class AuthSignUpLoading extends AuthState {
  const AuthSignUpLoading() : super();
}

@immutable
class AuthSignUpSuccess extends AuthState {
  const AuthSignUpSuccess({AuthData? data}) : super(data: data);
}

@immutable
class AuthSignUpFailed extends AuthState {
  const AuthSignUpFailed({String? message}) : super(message: message);
}

// logout
@immutable
class AuthLogoutLoading extends AuthState {
  const AuthLogoutLoading() : super();
}

@immutable
class AuthLogoutSuccess extends AuthState {
  const AuthLogoutSuccess() : super();
}

@immutable
class AuthLogoutFailed extends AuthState {
  const AuthLogoutFailed({String? message}) : super(message: message);
}

// update
@immutable
class AuthUpdateDefault extends AuthState {}

@immutable
class AuthUpdateLoading extends AuthState {
  const AuthUpdateLoading() : super();
}

@immutable
class AuthUpdateSuccess extends AuthState {
  const AuthUpdateSuccess() : super();
}

@immutable
class AuthUpdateFailed extends AuthState {
  const AuthUpdateFailed({String? message}) : super(message: message);
}

// image
@immutable
class AuthImageLoading extends AuthState {
  const AuthImageLoading() : super();
}

@immutable
class AuthImageSuccess extends AuthState {
  const AuthImageSuccess({AuthData? data}) : super(data: data);
}

@immutable
class AuthImageFailed extends AuthState {
  const AuthImageFailed({String? message}) : super(message: message);
}
