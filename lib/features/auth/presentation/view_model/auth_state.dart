part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final String token;

  LoginSuccess(this.token);
}

final class LoginError extends AuthState {
  final String errorMessage;

  LoginError(this.errorMessage);
}

final class SignUpLoading extends AuthState {}

final class SignUpSuccess extends AuthState {
  final String token;

  SignUpSuccess(this.token);
}

final class SignUpError extends AuthState {
  final String errorMessage;

  SignUpError(this.errorMessage);
}

final class LogoutLoading extends AuthState {}

final class LogoutSuccess extends AuthState {}

final class LogoutError extends AuthState {
  final String errorMessage;

  LogoutError(this.errorMessage);
}
