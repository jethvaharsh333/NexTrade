import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/common/entities/user.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/auth/domain/repository/auth_repository.dart';

class UserLogin implements UseCase<User, UserLoginParams>{
  final AuthRepository authRepository;    // new instances will be generated every time for call
  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async{
    return await authRepository.loginWithIdentifierPassword(identifier: params.identifier, password: params.password);
  }
}

class UserLoginParams{
  final String identifier;
  final String password;

  UserLoginParams({required this.identifier, required this.password});
}