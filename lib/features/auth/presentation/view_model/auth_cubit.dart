import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pingora/core/utils/services/local_services/cache_keys.dart';
import 'package:pingora/features/auth/data/repo/auth_repo.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    try {
      emit(LoginLoading());
      final result = await authRepo.login(email: email, password: password);
      result.fold(
        (failure) {
          emit(LoginFailure(failure.errMessage));
        },
        (token) {
          CacheKeysManger.saveAccessTokenToCache(token);
          emit(LoginSuccess(token));
        },
      );
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String username,
    String? profileImage,
  }) async {
    try {
      emit(SignUpLoading());
      final result = await authRepo.signUp(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        username: username,
        profileImage: profileImage,
      );
      result.fold(
        (failure) {
          emit(SignUpFailure(failure.errMessage));
        },
        (token) {
          CacheKeysManger.saveAccessTokenToCache(token);
          emit(SignUpSuccess(token));
        },
      );
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(LogoutLoading());

      final result = await authRepo.logout();

      result.fold(
        (failure) {
          emit(LogoutFailure(failure.errMessage));
        },
        (success) {
          CacheKeysManger.saveAccessTokenToCache('');
          emit(LogoutSuccess());
        },
      );
    } catch (e) {
      emit(LogoutFailure(e.toString()));
    }
  }
}
