import 'package:sheraa_cms/dto/product_dto.dart';

class OrderDetailDto {
  String? id;
  ProductDto? item;
  String? userName;
  String? userPhone;
  String? userAddress;
  String? created;

  OrderDetailDto({
    this.id,
    this.item,
    this.userName,
    this.userPhone,
    this.userAddress,
    this.created,
  });

  // Constructor to create an OrderDetailDto instance from a map
  factory OrderDetailDto.fromJson(Map<String, dynamic> json) {
    return OrderDetailDto(
      id: json['id'],
      item: ProductDto.fromJson(json['item']),
      userName: json['user_name'],
      userPhone: json['user_phone'],
      userAddress: json['user_address'],
      created: json['created'],
    );
  }

  // Convert an OrderDetailDto instance to a map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id' : id,
      'item': item?.toJson(),
      'user_name': userName,
      'user_phone': userPhone,
      'user_address': userAddress,
      'created': created,
    };
    return data;
  }
}