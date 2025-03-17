import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/profile/domain/repository/profile_repository.dart';

class EditPassword implements UseCase<String, EditPasswordParams> {
  final ProfileRepository profileRepository;
  EditPassword(this.profileRepository);

  @override
  Future<Either<Failure, String>> call(EditPasswordParams params) async {
    return await profileRepository.editPassword(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
      confirmPassword: params.confirmPassword,
    );
  }
}

class EditPasswordParams {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  EditPasswordParams({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}
