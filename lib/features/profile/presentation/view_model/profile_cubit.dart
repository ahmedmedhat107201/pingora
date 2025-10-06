import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pingora/core/utils/services/local_services/cache_keys.dart';
import 'package:pingora/features/profile/data/models/get_me_model.dart';
import 'package:pingora/features/profile/data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileRepo profileRepo;
  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  GetMeModel? getMeModel;

  Future<void> getMe() async {
    try {
      emit(GetMeLoading());
      final result = await profileRepo.getMe();
      result.fold(
        (failure) {
          CacheKeysManger.saveAccessTokenToCache('');
          emit(GetMeFailure(failure.errMessage));
        },
        (getMeModel) {
          this.getMeModel = getMeModel;
          emit(GetMeSuccess(getMeModel));
        },
      );
    } catch (e) {
      emit(GetMeFailure(e.toString()));
    }
  }
}
