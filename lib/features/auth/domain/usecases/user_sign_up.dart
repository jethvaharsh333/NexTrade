import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<String, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(userName: params.userName, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String userName;
  final String email;
  final String password;

  UserSignUpParams({required this.userName, required this.email, required this.password});
}