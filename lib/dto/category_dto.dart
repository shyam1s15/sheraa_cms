class CategoryDto {
  String? id;
  String? name;
  String? icon;
  String? bgColor;

  CategoryDto({
    this.id,
    this.name,
    this.icon,
    this.bgColor,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    return CategoryDto(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      bgColor: json['bg_color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'bg_color': bgColor,
    };
  }
}
