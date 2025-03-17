import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/profile/domain/repository/profile_repository.dart';

class LogoutProfile implements UseCase<String, EditLogoutParams> {
  final ProfileRepository profileRepository;
  const LogoutProfile(this.profileRepository);

  @override
  Future<Either<Failure, String>> call(EditLogoutParams params) async {
    return await profileRepository.logout(
      email: params.email,
      userName: params.userName,
    );
  }
}

class EditLogoutParams {
  final String userName;
  final String email;

  EditLogoutParams({
    required this.userName,
    required this.email,
  });
}
