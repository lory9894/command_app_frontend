class Dish {
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final String course;

  Dish(
      {required this.name,
      required this.description,
      required this.price,
      this.imageUrl,
      required this.course});

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      course: json['course'],
    );
  }

  @override
  String toString() {
    return 'Dish{name: $name, description: $description, price: $price, imageUrl: $imageUrl, course: $course}';
  }
}
