import 'dart:convert';

import 'package:sheraa_cms/api/base_api.dart';
import 'package:sheraa_cms/api/obtained_response.dart';
import 'package:sheraa_cms/dto/product_dto.dart';
import 'package:http/http.dart' as http;

class ProductCmsApi {
  Future<ObtainedResponse> getProducts(num pageId) async {
    List<ProductDto> products = [];
    final modelApiData = {
      'page_id': pageId,
    };
    
    final response = await http.post(
      Uri.parse(BASE_API + "/cms/products/fetch/all"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(modelApiData)
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      // print()
      if (responseJson['response']['error'] == 0) {
        for (int i = 0;
            i < responseJson['content'].length;
            i++) {
          ProductDto assignment =
              ProductDto.fromJson(responseJson['content'][i]);
          products.add(assignment);
        }
        return ObtainedResponse(API_RESULT.SUCCESS, products);
      } 
      
      return ObtainedResponse(API_RESULT.FAILED, responseJson['response']['message']);
    }
    return ObtainedResponse(API_RESULT.FAILED, "Bad response from server");
  }

  Future<ObtainedResponse> saveProduct(ProductDto dto) async {
    final response = await http.post(
      Uri.parse(BASE_API + "/cms/products/create"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dto.toJson())
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      // print()
      if (responseJson['response']['error'] == 0) {
        // for (int i = 0;
        //     i < responseJson['content'].length;
        //     i++) {
        //   ProductDto assignment =
        //       ProductDto.fromJson(responseJson['content'][i]);
        //   products.add(assignment);
        // }
        return ObtainedResponse(API_RESULT.SUCCESS, true);
      } 
      
      return ObtainedResponse(API_RESULT.FAILED, responseJson['response']['message']);
    }
    return ObtainedResponse(API_RESULT.FAILED, "Bad response from server");
      
  }

  Future<ObtainedResponse> updateProduct(ProductDto dto) async {
    final response = await http.post(
      Uri.parse(BASE_API + "/cms/products/update"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dto.toJson())
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      // print()
      if (responseJson['response']['error'] == 0) {
        // for (int i = 0;
        //     i < responseJson['content'].length;
        //     i++) {
        //   ProductDto assignment =
        //       ProductDto.fromJson(responseJson['content'][i]);
        //   products.add(assignment);
        // }
        return ObtainedResponse(API_RESULT.SUCCESS, true);
      } 
      
      return ObtainedResponse(API_RESULT.FAILED, responseJson['response']['message']);
    }
    return ObtainedResponse(API_RESULT.FAILED, "Bad response from server");
      
  }

  Future<ObtainedResponse> getProduct(String productId) async {
    
    final response = await http.get(
      Uri.parse(BASE_API + "/cms/products/$productId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      // print()
      if (responseJson['response']['error'] == 0) {
        // for (int i = 0;
        //     i < responseJson['content'].length;
        //     i++) {
        //   ProductDto assignment =
        //       ProductDto.fromJson(responseJson['content'][i]);
        //   products.add(assignment);
        // }
        ProductDto resp = ProductDto.fromJson(responseJson['content']);
        return ObtainedResponse(API_RESULT.SUCCESS, resp);
      } 
      
      return ObtainedResponse(API_RESULT.FAILED, responseJson['response']['message']);
    }
    return ObtainedResponse(API_RESULT.FAILED, "Bad response from server");
  }
}