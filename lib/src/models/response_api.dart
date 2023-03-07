import 'dart:convert';

class ResponseApi {

   bool  ? success;
   String? message;
   dynamic  data;
   
  ResponseApi({
     this.success,
     this.message,
     this.data,
  });


  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }

  factory ResponseApi.fromMap(Map<String, dynamic> map) {
    return ResponseApi(
      success: map['success'] ?? false,
      message: map['message'] ?? '',
      data: map['data'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseApi.fromJson(String source) => ResponseApi.fromMap(json.decode(source));

  
}
