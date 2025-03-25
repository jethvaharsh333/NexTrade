import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';
import 'package:nextrade/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:nextrade/core/common/entities/user.dart';
import 'package:nextrade/features/profile/domain/usecases/edit_password.dart';
import 'package:nextrade/features/profile/domain/usecases/edit_profile.dart';
import 'package:nextrade/features/profile/domain/usecases/logout_profile.dart';
import 'package:nextrade/utils/token_storage.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final EditPassword _editPassword;
  final EditProfile _editProfile;
  final LogoutProfile _logoutProfile;
  final AppUserCubit _appUserCubit;

  ProfileBloc({
    required EditPassword editPassword,
    required EditProfile editProfile,
    required LogoutProfile logoutProfile,
    required AppUserCubit appUserCubit,
  })  : _editPassword = editPassword,
        _editProfile = editProfile,
        _logoutProfile = logoutProfile,
        _appUserCubit = appUserCubit,
        super(ProfileInitial()) {
    on<ProfileEvent>((_, emit) => emit(ProfileLoading()));
    on<ProfileEditClickedEvent>(_onProfileEdit);
    on<PasswordEditClickedEvent>(_onPasswordEdit);
    on<ProfileGetEvent>(_onProfileGet);
    on<ProfileLogoutClickedEvent>(_onLogoutProfile);
  }

  void _onProfileEdit(ProfileEditClickedEvent event, Emitter<ProfileState> emit) async {
    final res = await _editProfile(
      EditProfileParams(
        name: event.name,
        userName: event.userName,
        email: event.email,
        phoneNumber: event.phoneNumber,
      ),
    );
    res.fold(
      (l) => emit(ProfileEditFailure(l.message)),
      (r) {
        _appUserCubit.updateUser(User(name: event.name, phoneNumber: event.phoneNumber, email: event.email, userName: event.userName));
        emit(ProfileEditSuccess(r));
      },
    );
  }

  void _onPasswordEdit(PasswordEditClickedEvent event, Emitter<ProfileState> emit) async {
    final res = await _editPassword(
      EditPasswordParams(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
      ),
    );
    res.fold(
      (l) => emit(PasswordEditFailure(l.message)),
      (r) => emit(PasswordEditSuccess(r)),
    );
  }

  void _onProfileGet(ProfileGetEvent event, Emitter<ProfileState> emit){
    final res = _appUserCubit.state;


  }

  void _onLogoutProfile(ProfileLogoutClickedEvent event, Emitter<ProfileState> emit) async {
    final res = await _logoutProfile(EditLogoutParams(userName: event.userName, email: event.userName));
    res.fold(
      (l) => emit(ProfileLogoutFailure(l.message)),
      (r) async {
        _appUserCubit.updateUser(null);
        emit(ProfileEditSuccess(r));
      },
    );
  }
}
