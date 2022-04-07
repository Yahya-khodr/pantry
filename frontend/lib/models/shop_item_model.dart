class ShopItem {
  int? id;
  String? itemName;
  int? quantity;
  String? image;

  ShopItem({
    this.id,
    this.itemName,
    this.quantity,
    this.image,
  });
  factory ShopItem.fromJson(Map<String, dynamic> json) {
    return ShopItem(
      id: json['id'],
      itemName: json['item_name'],
      quantity: json['quantity'],
      image: json['image'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item_name': itemName,
      'quantity': quantity,
      'image': image,
    };
  }
}
