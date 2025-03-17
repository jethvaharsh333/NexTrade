import 'package:nextrade/core/common/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.email,
      required super.userName,
      required super.name,
      required super.phoneNumber});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      userName: map['userName'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }
}
