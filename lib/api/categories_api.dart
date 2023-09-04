import 'dart:convert';

import 'package:sheraa_cms/api/base_api.dart';
import 'package:sheraa_cms/api/obtained_response.dart';
import 'package:http/http.dart' as http;
import 'package:sheraa_cms/dto/categories_subcategories_list_dto.dart';
import 'package:sheraa_cms/dto/category_dto.dart';

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

  Future<ObtainedResponse> saveCategory(CategoryDto dto) async {
    final response = await http.post(
      Uri.parse(BASE_API + "/cms/category/create"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dto.toJson())
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print(responseJson);
      if (responseJson['response']['error'] == 0) {
        // CategoryDto cat = CategoryDto.fromJson(responseJson['content']);
        return ObtainedResponse(API_RESULT.SUCCESS, true);
      } 
      return ObtainedResponse(API_RESULT.FAILED, responseJson['response']['message']);
    }
    return ObtainedResponse(API_RESULT.FAILED, "Bad response from server");
  }

  Future<ObtainedResponse> getCategoriesDetailList() async {
    List<CategoryDto> categoryList = [];

    final response = await http.get(
      Uri.parse(BASE_API + "/cms/category/get_categories"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      // print(responseJson);
      if (responseJson['response']['error'] == 0) {
        for (int i = 0;
            i < responseJson['content'].length;
            i++) {
              // print(responseJson['content'][i]);
          categoryList.add(CategoryDto.fromJson(responseJson['content'][i]));
        }
        
        return ObtainedResponse(API_RESULT.SUCCESS, categoryList);
      } 
      return ObtainedResponse(API_RESULT.FAILED, responseJson['response']['message']);
    }
    return ObtainedResponse(API_RESULT.FAILED, "Bad response from server");
  }

  Future<ObtainedResponse> getCategory(String categoryId) async {
    final response = await http.get(
      Uri.parse(BASE_API + "/cms/category/$categoryId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseJson['response']['error'] == 0) {
        print(responseJson);
        return ObtainedResponse(API_RESULT.SUCCESS, CategoryDto.fromJson(responseJson['content']));
      } 
      return ObtainedResponse(API_RESULT.FAILED, responseJson['response']['message']);
    }
    return ObtainedResponse(API_RESULT.FAILED, "Bad response from server");
  }

  Future<ObtainedResponse> updateCategory(CategoryDto dto) async {
    final response = await http.post(
      Uri.parse(BASE_API + "/cms/category/update"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dto.toJson())
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseJson['response']['error'] == 0) {
        // CategoryDto cat = CategoryDto.fromJson(responseJson['content']);
        return ObtainedResponse(API_RESULT.SUCCESS, true);
      } 
      return ObtainedResponse(API_RESULT.FAILED, responseJson['response']['message']);
    }
    return ObtainedResponse(API_RESULT.FAILED, "Bad response from server");
  }
}