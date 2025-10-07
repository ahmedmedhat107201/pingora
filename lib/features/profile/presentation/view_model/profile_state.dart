part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetMeLoading extends ProfileState {}

final class GetMeSuccess extends ProfileState {
  final GetMeModel getMeModel;
  GetMeSuccess(this.getMeModel);
}

final class GetMeError extends ProfileState {
  final String errorMessage;
  GetMeError(this.errorMessage);
}
