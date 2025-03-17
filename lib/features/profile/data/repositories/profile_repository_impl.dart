import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/exceptions.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:nextrade/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl(this.profileRemoteDataSource);

  @override
  Future<Either<Failure, String>> editPassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final successMessage = await profileRemoteDataSource.editPassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      return right(successMessage);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> editProfile(
      {required String name,
      required String phoneNumber,
      required String email,
      required String userName}) async {
    try {
      final successMessage = await profileRemoteDataSource.editProfile(
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        userName: userName,
      );
      return right(successMessage);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> logout({required String email, required String userName}) async {
    try {
      final successMessage = await profileRemoteDataSource.logout(
        email: email,
        userName: userName,
      );
      return right(successMessage);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }  }
}
