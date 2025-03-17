import 'package:fpdart/fpdart.dart';
import 'package:nextrade/core/common/entities/user.dart';
import 'package:nextrade/core/error/exceptions.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:nextrade/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithIdentifierPassword({required String identifier, required String password}) async{
    try {
      final user = await authRemoteDataSource.loginWithIdentifierPassword(
          identifier: identifier, password: password);
      return right(user);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword(
      {required String userName,
      required String email,
      required String password}) async {
    try {
      final successMessage = await authRemoteDataSource.signUpWithEmailPassword(userName: userName, email: email, password: password);
      return right(successMessage);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try{
    final user = await authRemoteDataSource.getCurrentUserData();
    if (user == null){
      return left(Failure("User not logged in."));
    }
    return right(user);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
