import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nextrade/core/secrets/app_secrets.dart';
import 'package:nextrade/utils/token_storage.dart';
// import 'token_storage.dart'; // Your TokenStorage class

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late Dio dio;

  ApiClient._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: AppSecrets.SERVER_API_URL,
      connectTimeout: const Duration(seconds: 15 ),
      headers: {
        // "Access-Control-Allow-Origin": "*",
        // "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
        'Content-Type': 'application/json; charset=utf-8',
      },

      responseType: ResponseType.json,
    );

    dio = Dio(options);

    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final token = await TokenStorage.getToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            // if (kDebugMode) {
              print('Request: ${options.method} ${options.path}');
              print('Headers: ${options.headers}');
              print('Body: ${options.data}');
            // }
            return handler.next(options);
          } catch (e) {
            // if (kDebugMode) {
              print('Error setting auth header: $e');
            // }
            return handler.next(options);
          }
        },
      onResponse: (response, handler) {
        if (kDebugMode) {
          print('Response: ${response.statusCode} ${response.data}');
        }
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        if (kDebugMode) {
          print('Error on request ${e.requestOptions}: ${e.message}');
        }
        return handler.next(e);
        //Sancho.j999999
      },
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await dio.post(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await dio.put(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> delete(String path, {Map<String, dynamic>? queryParameters}) async {
    return await dio.delete(path, queryParameters: queryParameters);
  }
}
// import 'package:dio/dio.dart';
// import '../../utils/token_storage.dart';
//
// class ApiClient {
//   final Dio _client;
//
//   ApiClient(this._client) {
//     _client.options.baseUrl = "https://your-api.com/api";
//     _client.interceptors.add(InterceptorsWrapper(
//       onRequest: (options, handler) async {
//         final token = await TokenStorage.getToken();
//         if (token != null) {
//           options.headers["Authorization"] = "Bearer $token";
//         }
//         return handler.next(options);
//       },
//     ));
//   }
// }
//
// import 'package:dio/dio.dart';
// class ApiClient {
//   final Dio _client;
// // Constructor
//   ApiClient()
//       : _client = Dio(
//     BaseOptions(
//       sendTimeout: const Duration(milliseconds: 60000),
//       receiveTimeout: const Duration(milliseconds: 60000),
//       connectTimeout: const Duration(milliseconds: 60000),
//       followRedirects: false,
//       receiveDataWhenStatusError: true,
//     ),
//   );
// // GET request
//   Future<Map<String, dynamic>?> get(
//       String url, {
//         Map<String, String>? queryParams = const {},
//         Map<String, String>? headers = const {},
//       }) async {
//     return _request(
//           () => _client.get(url, queryParameters: queryParams),
//       headers: headers,
//     );
//   }
// // POST request
//   Future<Map<String, dynamic>?> post(
//       String url,
//       dynamic payLoad, {
//         Map<String, String>? headers = const {},
//       }) async {
//     return _request(
//           () => _client.post(url, data: payLoad),
//       headers: headers,
//     );
//   }
// // Private method to handle requests
//   Future<Map<String, dynamic>?> _request(
//       Future<Response> Function() request, {
//         Map<String, String>? headers,
//       }) async {
//     try {
//       final response = await request();
//       return response.data;
//     } on DioError catch (e) {
//       print('Request failed: ${e.message}');
//       return null;
//     }
//   }
// }

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:nextrade/core/secrets/app_secrets.dart';
// import 'package:nextrade/utils/token_storage.dart';
//
// class HttpUtil {
//   late Dio dio;
//
//   static final HttpUtil _instance = HttpUtil._internal();
//
//   factory HttpUtil() {
//     return _instance;
//   }
//
//   HttpUtil._internal() {
//     BaseOptions options = BaseOptions(
//         baseUrl: AppSecrets.SERVER_API_URL,
//         // connectTimeout: const Duration(seconds: 5),
//         // receiveTimeout: const Duration(seconds: 5),
//         headers: {},
//         contentType: "application/json: charset=utf-8",
//         responseType: ResponseType.json
//     );
//
//     dio = Dio(options);
//
//     dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
//       print("app request data ${options.data}");
//       return handler.next(options);
//     }, onResponse: (response, handler) {
//       if (kDebugMode) {
//         print("app response data ${response.data}");
//       }
//       return handler.next(response);
//     }, onError: (DioException e, handler) {
//       if (kDebugMode) {
//         print("app error data $e");
//       }
//       ErrorEntity eInfo = createErrorEntity(e);
//       onError(eInfo);
//     }));
//   } //finish internal()
//
//   Future<Map<String, dynamic>?> getAuthorizationHeader() async {
//     var headers = <String, dynamic>{};
//     // var accessToken = Global.storageService.getUserToken();
//     var accessToken = await TokenStorage.getToken();
//     if (accessToken!.isNotEmpty) {
//       headers['Authorization'] = 'Bearer $accessToken';
//     }
//     return headers;
//   }
//
//   // GET request
//   Future<dynamic> get(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     Options requestOptions = options ?? Options();
//     requestOptions.headers = requestOptions.headers ?? {};
//
//     Map<String, dynamic>? authorization = await getAuthorizationHeader();
//     if (authorization != null) {
//       requestOptions.headers!.addAll(authorization);
//     }
//
//     var response = await dio.get(path,
//         queryParameters: queryParameters, options: requestOptions);
//     return response.data;
//   }
//
//   Future post(
//     String path, {
//     Object? data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     Options requestOptions = options ?? Options();
//     requestOptions.headers = requestOptions.headers ?? {};
//
//     Map<String, dynamic>? authorization = await getAuthorizationHeader();
//
//     if (authorization != null) {
//       requestOptions.headers!.addAll(authorization);
//     }
//
//     var response = await dio.post(path,
//         data: data, queryParameters: queryParameters, options: requestOptions);
//
//     return response.data;
//   }
//
//   // PUT request (Update)
//   Future<dynamic> put(
//     String path, {
//     Object? data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     Options requestOptions = options ?? Options();
//     requestOptions.headers = requestOptions.headers ?? {};
//
//     Map<String, dynamic>? authorization = await getAuthorizationHeader();
//     if (authorization != null) {
//       requestOptions.headers!.addAll(authorization);
//     }
//
//     var response = await dio.put(path,
//         data: data, queryParameters: queryParameters, options: requestOptions);
//     return response.data;
//   }
//
//   // DELETE request
//   Future<dynamic> delete(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     Options requestOptions = options ?? Options();
//     requestOptions.headers = requestOptions.headers ?? {};
//
//     Map<String, dynamic>? authorization = await getAuthorizationHeader();
//     if (authorization != null) {
//       requestOptions.headers!.addAll(authorization);
//     }
//
//     var response = await dio.delete(path,
//         queryParameters: queryParameters, options: requestOptions);
//     return response.data;
//   }
// }
//
// class ErrorEntity implements Exception {
//   int code = -1;
//   String message = "";
//
//   ErrorEntity({required this.code, required this.message});
//
//   @override
//   String toString() {
//     if (message == "") return "Exception";
//
//     return "Exception code $code, $message";
//   }
// }
//
// ErrorEntity createErrorEntity(DioException error) {
//   switch (error.type) {
//     case DioExceptionType.connectionTimeout:
//       return ErrorEntity(code: -1, message: "Connection timed out");
//
//     case DioExceptionType.sendTimeout:
//       return ErrorEntity(code: -1, message: "Send timed out");
//
//     case DioExceptionType.receiveTimeout:
//       return ErrorEntity(code: -1, message: "Receive timed out");
//
//     case DioExceptionType.badCertificate:
//       return ErrorEntity(code: -1, message: "Bad SSL certificates");
//
//     case DioExceptionType.badResponse:
//       switch (error.response!.statusCode) {
//         case 400:
//           return ErrorEntity(code: 400, message: "Bad request");
//         case 401:
//           return ErrorEntity(code: 401, message: "Permission denied");
//         case 500:
//           return ErrorEntity(code: 500, message: "Server internal error");
//       }
//       return ErrorEntity(
//           code: error.response!.statusCode!, message: "Server bad response");
//
//     case DioExceptionType.cancel:
//       return ErrorEntity(code: -1, message: "Server canceled it");
//
//     case DioExceptionType.connectionError:
//       return ErrorEntity(code: -1, message: "Connection error");
//
//     case DioExceptionType.unknown:
//       return ErrorEntity(code: -1, message: "Unknown error");
//   }
// }
//
// void onError(ErrorEntity eInfo) {
//   print('error.code -> ${eInfo.code}, error.message -> ${eInfo.message}');
//   switch (eInfo.code) {
//     case 400:
//       print("Server syntax error");
//       break;
//     case 401:
//       print("You are denied to continue");
//       break;
//     case 500:
//       print("Server internal error");
//       break;
//     default:
//       print("Unknown error");
//       break;
//   }
// }
