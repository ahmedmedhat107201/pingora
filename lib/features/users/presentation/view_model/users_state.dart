part of 'users_cubit.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

final class GetAllUsersLoading extends UsersState {}

final class GetAllUsersSuccess extends UsersState {
  final GetUsersModel usersModel;

  GetAllUsersSuccess(this.usersModel);
}

final class GetAllUsersError extends UsersState {
  final String errorMessage;

  GetAllUsersError(this.errorMessage);
}
