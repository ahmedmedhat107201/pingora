import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repo/splash_repo.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashRepo splashRepo;
  SplashCubit(this.splashRepo) : super(SplashInitial());
}
