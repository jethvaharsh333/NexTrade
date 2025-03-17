import 'package:nextrade/core/error/exceptions.dart';
import 'package:nextrade/core/network/api_client.dart';
import 'package:nextrade/utils/token_storage.dart';

abstract interface class ProfileRemoteDataSource {
  Future<String> editProfile({
    required String name,
    required String phoneNumber,
    required String email,
    required String userName,
  });

  Future<String> editPassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });

  Future<String> logout({
    required String email,
    required String userName,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient _apiClient;
  ProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<String> editPassword({required String currentPassword, required String newPassword, required String confirmPassword}) async{
    try{
      final data = {
        "currentPassword": currentPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      };

      final response = await _apiClient.dio.put("account/update-password", data: data);

      if(response.data == null){
        throw const ServerExceptions('Failed to update profile');
      }

      return response.data.toString();
    } catch (e) {
      // print()
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<String> editProfile({required String name, required String phoneNumber, required String email, required String userName}) async{
    try{
    final data = {
      "name": name,
      "phoneNumber": phoneNumber,
      "email": email,
      "userName": userName,
    };

    print("account/update-profile api called");
    final response = await _apiClient.dio.put("account/update-profile", data: data);
    print("Response: $response");

    if(response.data == null){
      throw const ServerExceptions('Failed to update profile');
    }

    return response.data.toString();
    } catch (e) {
      print("[SERVER EXEPTION] e:  $e");
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<String> logout({required String email, required String userName}) async {
    try{
      final data = {
        "email": email,
        "userName": userName,
      };

      print("account/update-profile api called");
      final response = await _apiClient.dio.post("account/logout", data: data);
      print("Response: $response");

      if(response.data == null){
        throw const ServerExceptions('Failed to update profile');
      }

      await TokenStorage.deleteToken();

      return response.data.toString();
    } catch (e) {
      print("[SERVER EXEPTION] e:  $e");
      throw ServerExceptions(e.toString());
    }
  }



}