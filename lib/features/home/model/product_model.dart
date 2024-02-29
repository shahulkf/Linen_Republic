class ProductModel {
  List image;
  String title;
  String description;
  double rating;
  num price;
  int ? id;

  ProductModel({
    required this.image,
    required this.title,
    required this.description,
    required this.rating,
    required this.price,
     this.id,
  });
}