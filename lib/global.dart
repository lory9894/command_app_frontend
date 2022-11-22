
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
}
Map<Dish,int> globalShoppingCart = {};
