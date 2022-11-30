import 'dish.dart';

enum PreparationState { brought, toBring }

class Preparation {
  final Dish dish;
  final String tableDeliveryCode;
  PreparationState state;

  Preparation(this.dish, this.tableDeliveryCode,
      {this.state = PreparationState.toBring});
}