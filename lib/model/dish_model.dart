class Dish {
  int? id;
  String? name;
   String? description;
   String? price;
   String? image;
  int? restaurent_id;
  int? quantity;

  Dish({
     this.id,
    this.name,
     this.description,
    this.price,
    this.image,
    this.restaurent_id,
    this.quantity = 0,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      restaurent_id: json['restaurent_id'],
      quantity: json['quantity'] ?? 0,
    );
  }
}
