
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

//TODO: Quando avremo capito come settare il tavolo e l'utente al posto della variabile globalShoppingCart avremo una variabile globale order
class Order {
  String? userId, tableID;
  late String orderID;
  double total= 0;
  Map<Dish,int> shoppingCart = {};

  //TODO: aggiungere il costruttore, dipende da quando viene chiamato


  /// method to add a dish to the shopping cart, subtotal is automatically updated
  /// @param dish the dish to add
  void addDish(Dish dish) {
    if (shoppingCart.containsKey(dish)) {
      shoppingCart[dish] = shoppingCart[dish]! + 1;
    } else {
      shoppingCart[dish] = 1;
    }

  total += dish.price;
  }

  /// method to remove a dish from the shopping cart, subtotal is automatically updated
  /// @param dish the dish to remove
  void removeDish(Dish dish) {
    if (shoppingCart.containsKey(dish)) {
      if (shoppingCart[dish]! > 1) {
        shoppingCart[dish] = shoppingCart[dish]! - 1;
      } else {
        shoppingCart.remove(dish);
      }
    }
    total -= dish.price;
  }

  getTotal() {
    return total;
  }

}