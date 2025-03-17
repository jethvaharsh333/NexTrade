import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/profile/domain/repository/profile_repository.dart';

class EditProfile implements UseCase<String, EditProfileParams> {
  final ProfileRepository profileRepository;
  const EditProfile(this.profileRepository);

  @override
  Future<Either<Failure, String>> call(EditProfileParams params) async {
    return await profileRepository.editProfile(
      name: params.name,
      phoneNumber: params.phoneNumber,
      email: params.email,
      userName: params.userName,
    );
  }
}

class EditProfileParams {
  final String name;
  final String userName;
  final String email;
  final String phoneNumber;

  EditProfileParams({
    required this.name,
    required this.userName,
    required this.email,
    required this.phoneNumber,
  });
}
