import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pingora/features/users/data/models/users_model.dart';
import 'package:pingora/features/users/data/repo/users_repo.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersRepo usersRepo;
  UsersCubit(this.usersRepo) : super(UsersInitial());

  GetUsersModel? getUsersModel;

  Future<void> getAllUsers() async {
    try {
      emit(GetAllUsersLoading());

      final result = await usersRepo.getAllUsers();

      result.fold(
        (failure) {
          emit(GetAllUsersError(failure.errMessage));
        },
        (usersModel) {
          this.getUsersModel = usersModel;
          emit(GetAllUsersSuccess(usersModel));
        },
      );
    } catch (e) {
      emit(GetAllUsersError('An unexpected error occurred. Please try again.'));
    }
  }
}
