import 'package:dio/dio.dart';

class HttpManager {

  Future restRequest({
    required String url,
    required String method,
    Map? hearders,
    Map? body,
  }) async {

    final defaultHeaders = hearders?.cast<String, String>() ?? {}

    ..addAll({
      'content-type': 'application/json',
      'accept': 'application/json',
    });
    

    Dio dio = Dio();
    
    try {
     Response response = await dio.request(
         url,
          options: Options(
            headers: defaultHeaders,
            method: method),
          data: body,
        );
      //Retorno do resultado do server
       return response.data;
     } on DioError catch (error) {
     //Retorno do erro do dio request
     return error.response?.data ?? {};
      
    } catch(error) {
      return {};
    }
  }

}

abstract class HttpMethods {

   static const String post = 'POST';
   static const String get = 'GET';
   static const String put = 'PUT';
   static const String patch = 'PATCH';
   static const String delete = 'DELETE';
}