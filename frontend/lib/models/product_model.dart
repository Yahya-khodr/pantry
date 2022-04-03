

class Product {
  String? productName;
  String? quantity;
  String? productQuantity;
  String? imageUrl;
  // Nutriments? nutriments;
  String? barcode;
  String? category;

  Product({
    this.productName,
    this.quantity,
    this.productQuantity,
    // this.nutriments,
    this.imageUrl,
    this.category,
    this.barcode,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      barcode: json['id'],
      productName: json['product_name'],
      quantity: json['quantity'],
      productQuantity: json['product_quantity'],
      imageUrl: json['image_url'],
      category: json['category'],
      // nutriments: json['nutriments'] = Nutriments.fromJson(
      //   json['nutriments'],
      // ),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': barcode,
      'product_name': productName,
      'quantity': quantity,
      'product_quantity': productQuantity,
      'image_url': imageUrl,
      // 'nutriments': nutriments,
      'category': category,
    };
  }
}
