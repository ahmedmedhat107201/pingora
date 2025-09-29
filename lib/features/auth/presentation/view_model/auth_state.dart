part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final String token;

  LoginSuccess(this.token);
}

final class LoginFailure extends AuthState {
  final String errorMessage;

  LoginFailure(this.errorMessage);
}

final class SignUpLoading extends AuthState {}

final class SignUpSuccess extends AuthState {
  final String token;

  SignUpSuccess(this.token);
}

final class SignUpFailure extends AuthState {
  final String errorMessage;

  SignUpFailure(this.errorMessage);
}

final class LogoutLoading extends AuthState {}

final class LogoutSuccess extends AuthState {}

final class LogoutFailure extends AuthState {
  final String errorMessage;

  LogoutFailure(this.errorMessage);
}
