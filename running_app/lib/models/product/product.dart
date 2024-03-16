import 'package:running_app/models/product/brand.dart';

class Product {
  final String? id;
  final String? name;
  final Brand? brand;
  final int? price;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price
  });

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        brand = Brand.fromJson(json['brand']),
        price = json['price'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'price': price,
    };
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, brand: $brand, price: $price}';
  }
}

class DetailProduct extends Product {
  final Map<String, dynamic>? category;
  final String? description;
  final String? uploadedAt;
  final String? updatedAt;

  DetailProduct({
    String? id,
    String? name,
    Brand? brand,
    int? price,
    required this.category,
    required this.description,
    required this.uploadedAt,
    required this.updatedAt,
  }) : super(
    id: id,
    name: name,
    brand: brand,
    price: price
  );

  DetailProduct.fromJson(Map<String, dynamic> json)
      : category = json['category'],
        description = json['description'],
        uploadedAt = json['uploaded_at'],
        updatedAt = json['updated_at'],
        super(
          id: json['id'],
          name: json['name'],
          brand: json['brand'],
          price: json['price']
        );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['category'] = category;
    data['description'] = description;
    data['uploaded_at'] = uploadedAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'DetailProduct{${super.toString()}, category: $category, description: $description, uploadedAt: $uploadedAt, updatedAt: $updatedAt}';
  }
}