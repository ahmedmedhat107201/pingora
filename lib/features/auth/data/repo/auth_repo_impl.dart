import 'package:pingora/core/utils/services/remote_services/api_service.dart';
import 'package:pingora/features/auth/data/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  ApiService apiService;

  AuthRepoImpl(this.apiService);
}
