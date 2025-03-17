import 'package:fpdart/fpdart.dart';
import 'package:nextrade/core/common/entities/user.dart';
import 'package:nextrade/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailPassword({           // Either<Failure, Success>
    required String userName,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithIdentifierPassword({
    required String identifier,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();
}
