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

Order order = Order();

class Order {
  String? _userId, _tableID;
  late String orderID;
  double total = 0;
  Map<Dish, int> shoppingCart = {};

  set userId(String value) {
    _userId = value;
  }

  set tableID(String value) {
    _tableID = value;
  }

  /// Creates a new order, empty.
  Order({String? userId, String? tableID}) {
    this._userId = userId;
    this._tableID = tableID;
  }

  ///compute orderID from userId, tableID and current time
  ///returns the orderID
  String computeOrderID() {
    orderID = _userId! + _tableID! + DateTime.now().toString();
    return orderID;
  }

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
