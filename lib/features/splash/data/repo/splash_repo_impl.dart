import '../../../../core/utils/services/remote_services/api_service.dart';
import 'splash_repo.dart';

class SplashRepoImpl implements SplashRepo {
  ApiService apiService;

  SplashRepoImpl(this.apiService);
}
