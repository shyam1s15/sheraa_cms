class ProductDto {
  String? id;
  String? name;
  List<String>? images;  // Nullable List<String>
  String? categoryName;
  // String? subcategoryName;
  int? price;
  String? summary;
  String? description;
  String? offerText;

  ProductDto({
    this.id,
    this.name,
    this.images,
    this.categoryName,
    // this.subcategoryName,
    this.price,
    this.summary,
    this.description,
    this.offerText,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id'],
      name: json['name'],
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : null,  // Handle null value
      categoryName: json['cat_name'],
      // subcategoryName: json['subcat_name'],
      price: json['price'],
      summary: json['summary'],
      description: json['description'],
      offerText: json['offer_text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'images': images,  // Will include null or non-empty List<String>
      'cat_name': categoryName,
      // 'subcat_name': subcategoryName,
      'price': price,
      'summary': summary,
      'description': description,
      'offer_text': offerText,
    };
  }
}
