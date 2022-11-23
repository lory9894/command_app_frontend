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
  double _total = 0;
  Map<Dish, int> _shoppingCart = {};

  Map<Dish, int> get shoppingCart => _shoppingCart;

  set userId(String? value) {
    _userId = value;
  }

  String? get userId => _userId;
  String? get tableID => _tableID;

  set tableID(String? value) {
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
    if (_shoppingCart.containsKey(dish)) {
      _shoppingCart[dish] = _shoppingCart[dish]! + 1;
    } else {
      _shoppingCart[dish] = 1;
    }

    _total += dish.price;
  }

  /// method to remove a dish from the shopping cart, subtotal is automatically updated
  /// @param dish the dish to remove
  void removeDish(Dish dish) {
    if (_shoppingCart.containsKey(dish)) {
      if (_shoppingCart[dish]! > 1) {
        _shoppingCart[dish] = _shoppingCart[dish]! - 1;
      } else {
        _shoppingCart.remove(dish);
      }
    }
    _total -= dish.price;
  }

  double get total => _total;
}
