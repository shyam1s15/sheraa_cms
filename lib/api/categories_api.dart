import 'dart:convert';

import 'package:sheraa_cms/api/base_api.dart';
import 'package:sheraa_cms/api/obtained_response.dart';
import 'package:http/http.dart' as http;
import 'package:sheraa_cms/dto/categories_subcategories_list_dto.dart';

class CategoriesApi {
  Future<ObtainedResponse> getCategoriesAndSubCategories() async {
    List<String> categories = [];
    List<String> subCategories = [];
    
    final response = await http.get(
      Uri.parse(BASE_API + "/cms/category/list_both"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseJson['response']['error'] == 0) {
        for (int i = 0;
            i < responseJson['content']['categories'].length;
            i++) {
          categories.add(responseJson['content']['categories'][i]);
        }
        // for (int i = 0;
        //     i < responseJson['content']['subCategories'].length;
        //     i++) {
        //   subCategories.add(responseJson['content']['subCategories'][i]);
        // }
        return ObtainedResponse(API_RESULT.SUCCESS, CategoriesAndSubcategoriesListDto(categories, subCategories));
      } 
      return ObtainedResponse(API_RESULT.FAILED, responseJson['response']['message']);
    }
    return ObtainedResponse(API_RESULT.FAILED, "Bad response from server");
  }
}