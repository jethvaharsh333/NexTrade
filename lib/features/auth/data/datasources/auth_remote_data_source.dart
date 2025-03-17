import 'package:fpdart/fpdart.dart';
import 'package:nextrade/core/error/exceptions.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/network/api_client.dart';
import 'package:nextrade/features/auth/data/models/user_model.dart';
import 'package:nextrade/utils/token_storage.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> loginWithIdentifierPassword({
    required String identifier,
    required String password,
  });

  Future<String> signUpWithEmailPassword({
    required String userName,
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;
  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<UserModel> loginWithIdentifierPassword({required String identifier, required String password}) async{
    try {
      final data = {
        "identifier": identifier,
        "password": password,
      };

      print("account/login api called");
      final response = await _apiClient.dio.post("account/login", data: data);
      print("Response: $response");

      if (response.data == null) {
        throw const ServerExceptions('User is null');
      }

      if (response.data['token'] != null) {
        await TokenStorage.saveToken(response.data['token']);
      }
      else {
        throw const ServerExceptions('Token not found in response');
      }

      return UserModel.fromJson(response.data);
    } catch (e){
      throw ServerExceptions(e.toString());
    }

  }

  @override
  Future<String> signUpWithEmailPassword(
      {required String userName,
      required String email,
      required String password}) async {
    try {
      final data = {
        "email": email,
        "userName": userName,
        "password": password,
      };

      print("account/register api called.");
      final response = await _apiClient.dio.post("account/register", data: data);

      if (response.data == null) {
        throw const ServerExceptions('User is null');
      }

      return response.data.toString();
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try{
      if(TokenStorage.getToken() != null){
        print("account/get-current-user api called");
        final response = await _apiClient.dio.get("account/get-current-user");
        print("Response: $response");

        if (response.data == null) {
          throw const ServerExceptions('User not found.');
        }

        return UserModel.fromJson(response.data);
      }

      return null;
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }
}
