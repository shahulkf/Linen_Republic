class CartModel {
  final String name;
  final String price;
  final String quantity;
  final String description;
  final List imageUrl;
  final String stock;
  String productId;
  CartModel({
    required this.name,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.description,
    required this.imageUrl,
    required this.stock,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      productId: map['productId'],
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      stock: map['stock'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'description': description,
      'imageUrl': imageUrl,
      'stock': stock,
      'productId': productId,
    };
  }
}
