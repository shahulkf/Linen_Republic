class ProductModel {
  List image;
  String title;
  String description;
  num price;
  int? id;
  int small;
  int medium;
  int large;
  int xl;

  ProductModel(
      {required this.image,
      required this.title,
      required this.description,
      required this.price,
      this.id,
      required this.small,
      required this.medium,
      required this.large,
      required this.xl});
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        image: (map['images'] as List).map((e) => e.toString()).toList(),
        title: map['name'],
        description: map['description'],
        price: map['price'],
        small: map['sizeWithQuantity']['S'],
        medium: map['sizeWithQuantity']['M'],
        large: map['sizeWithQuantity']['L'],
        xl: map['sizeWithQuantity']['XL']);
  }
}
