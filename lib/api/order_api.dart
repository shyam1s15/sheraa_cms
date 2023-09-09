import 'dart:convert';

import 'package:sheraa_cms/api/base_api.dart';
import 'package:sheraa_cms/api/obtained_response.dart';
import 'package:http/http.dart' as http;
import 'package:sheraa_cms/dto/order_dto.dart';

class OrderApi {
  Future<ObtainedResponse> getActiveOrders(int pageId) async {
    List<OrderDetailDto> resp = [];
    final payload = {
      'page_id' : pageId
    };
    final response = await http.post(
      Uri.parse(BASE_API + "/app/orders/fetch_all"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(payload)
    );
    print(response.statusCode);
    print(response.bodyBytes);

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print(responseJson);
      if (responseJson['response']['error'] == 0) {
        for (int i = 0;
            i < responseJson['content'].length;
            i++) {
          resp.add(OrderDetailDto.fromJson(responseJson['content'][i]));
        }
        return ObtainedResponse(API_RESULT.SUCCESS, resp);
      } 
      return ObtainedResponse(API_RESULT.FAILED, responseJson['response']['message']);
    }
    return ObtainedResponse(API_RESULT.FAILED, "Bad response from server");
  }
}