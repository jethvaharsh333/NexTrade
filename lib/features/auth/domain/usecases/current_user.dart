import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/common/entities/user.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams>{
  final AuthRepository authRepository;
  const CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return authRepository.currentUser();
  }
}