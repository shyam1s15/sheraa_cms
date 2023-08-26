import 'dart:convert';
import 'dart:typed_data';

import 'package:sheraa_cms/api/obtained_response.dart';
import 'package:http/http.dart' as http;

import 'base_api.dart';

class FileUploadCmsApi {
  Future<ObtainedResponse> uploadFile(Uint8List file) async {
    final modelApiData = {
      'file' : base64Encode(file)
    };

    final response = await http.post(
      Uri.parse(BASE_API + "/cms/firebase/upload"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(modelApiData)
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print(responseJson);
      if (responseJson['response']['error'] == 0) {
        print("got file name" + responseJson['content']['filename']);
        return ObtainedResponse(API_RESULT.SUCCESS, responseJson['content']['filename'] );
      } 
      
      return ObtainedResponse(API_RESULT.FAILED, responseJson['response']['message']);
    }
    return ObtainedResponse(API_RESULT.FAILED, "Bad response from server");
  }
}