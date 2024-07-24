import 'package:dio/dio.dart';
import 'end_points.dart';
import 'dart:developer' as dev;

class DioHelper {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ),
  );

  static Future<Response> postData({
    required String path,
    required Map<String, dynamic> map,
    String? token,
  }) async {
    dio.options.headers["Authorization"] = token != null ? 'Bearer $token' : "";
    return await dio.post(
      baseUrl+path,
      data: map,
    );
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? map,
    String? token,
  }) async {
    dio.options.headers["Authorization"] = token != null ? 'Bearer $token' : "";
    return await dio.request(
        baseUrl+path,
     options: Options(
            method: 'GET',
            headers: {'Authorization': token != null ? 'Bearer $token' : ""},
          ),
    );
  }

  static Future<Response> deleteData({
    required String path,
    Map<String, dynamic>? map,
    String? token,
  }) async {
    dio.options.headers["Authorization"] = token != null ? 'Bearer $token' : "";
    return await dio.delete(
      baseUrl+path,
      data: map,
    );
  }

  static Future<Response> editData({
    required String path,
    required Map<String, dynamic> map,
    String? token,
  }) async {
    dio.options.headers["Authorization"] = token != null ? 'Bearer $token' : "";
    return await dio.put(
      baseUrl+path,
      data: map,
    );
  }
}



// import 'package:dio/dio.dart';
// import 'end_points.dart';
//
// class DioHelper {
//   static  Dio dio=Dio();
//
//   static init() {
//     dio = Dio(
//         BaseOptions(
//             baseUrl: baseUrl,
//             receiveDataWhenStatusError: true,
//             headers: {
//               'Accept': 'application/json',
//               'Content-Type':'application/json',
//
//             }
//         )
//     );
//   }
//
//
//   static Future<Response> postData({
//     required String url,
//     Map<String,dynamic> ? query,
//     required FormData data,
//     String ? token,
//   }) async{
//     dio.options.headers = {
//       'Accept': 'application/json',
//       'Content-Type':'application/json',
//       "Authorization": 'Bearer $token' ?? ""
//     };
//     return await dio.post(
//       baseUrl+url,
//       options:  Options(
//         followRedirects: false,
//         // will not throw errors
//         validateStatus: (status) => true,
//       ),
//       queryParameters: query,
//       data: data,
//     );
//   }
//
//   static Future<Response> editData({
//     required String url,
//     Map<String,dynamic> ? query,
//     required Map<String,dynamic> data,
//     String ? token,
//   }) async{
//     dio.options.headers = {
//       'Accept': 'application/json',
//       'Content-Type':'application/json',
//       "Authorization": 'Bearer $token' ?? ""
//     };
//     return await dio.put(
//       baseUrl+url,
//       options:  Options(
//         followRedirects: false,
//         // will not throw errors
//         validateStatus: (status) => true,
//       ),
//       queryParameters: query,
//       data: data,
//     );
//   }
//
//
//   static Future<Response> getData({
//     required String url,
//     Map<String, dynamic> ?  query,
//     String ? token,
//   }) async{
//     dio.options.headers = {
//       'Accept': 'application/json',
//       'Content-Type':'application/json',
//       "Authorization": 'Bearer $token' ?? ""
//     };
//     return await dio.get(
//         baseUrl+url,
//         queryParameters: query
//     );
//   }
//
//   static Future<Response> deleteData({
//     required String url,
//     Map<String, dynamic> ?  query,
//     String ? token,
//   }) async{
//     dio.options.headers = {
//       'Accept': 'application/json',
//       'Content-Type':'application/json',
//       "Authorization": 'Bearer $token' ?? ""
//     };
//     return await dio.delete(
//         baseUrl+url,
//         queryParameters: query
//     );
//   }
// }