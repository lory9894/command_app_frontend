import 'dish.dart';

enum PreparationState { brought, toBring, ready, underway, waiting }


/// preparations states are displayed to user as follows
extension PreparationStateStrings on PreparationState {
  String get str {
    switch (this) {
      case PreparationState.toBring:
        return "Da servire";
      case PreparationState.brought:
        return "Servito";
      case PreparationState.ready:
        return "Pronto";
      case PreparationState.underway:
        return "In preparazione";
      case PreparationState.waiting:
        return "In attesa";
    }
  }
}

class Preparation {
  final Dish dish;
  final String tableDeliveryCode;
  PreparationState state;

  Preparation(this.dish, this.tableDeliveryCode,
      {this.state = PreparationState.toBring});
}