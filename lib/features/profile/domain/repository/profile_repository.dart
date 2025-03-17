import 'package:fpdart/fpdart.dart';
import 'package:nextrade/core/common/entities/user.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/features/profile/domain/entities/password.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, String>> editProfile({
    required String name,
    required String phoneNumber,
    required String email,
    required String userName,
  });

  Future<Either<Failure, String>> editPassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });

  Future<Either<Failure, String>> logout({
    required String email,
    required String userName,
  });
}
