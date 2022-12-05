import 'dart:convert';

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

const String sampleJsonPreparations = """[
  {
    "dish": {
      "name": "il Petrone",
      "price": 5.50,
      "description": "panino con prosciutto e mozzarella",
      "imageUrl": "http://www.di.unito.it/~giovanna/gioNew1.jpg",
      "course": "Panino"
    },
    "tableDeliveryCode": "12",
    "state": "brought"
  },
  {
    "dish": {
      "name": "Risotto alla CMRO",
      "price": 5.22,
      "description": "Gvosso risotto per gvossi intenditori (Fakemuscles approves)",
      "imageUrl": "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.researchgate.net%2Fprofile%2FAndrea_Grosso%2F4&psig=AOvVaw3sNpMqQxN08jGPGKzd70v8&ust=1669741417373000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCNjr89Gt0fsCFQAAAAAdAAAAABAE",
      "course": "primo"
    },
    "tableDeliveryCode": "A46",
    "state": "toBring"
  }
]
""";


/// returns list of preparations to show on screen
List<Preparation> getPreparationsFromJson(String json) {
  List<Preparation> preparationsList = List.empty(growable: true);
  List map = jsonDecode(json);
  for (var prepMap in map) {
    var dishMap = prepMap['dish'];
    Dish dish = Dish(
        name: dishMap['name'],
        description: dishMap['description'],
        price: dishMap['price'],
        course: dishMap['course']
    );

    String prepStateString = prepMap['state'];
    /// preparation state converted from String to Enum
    PreparationState prepState = PreparationState.values.firstWhere(
            (e) => e.toString() == "PreparationState.$prepStateString"
    );
    Preparation prep = Preparation(
        dish,
        prepMap['tableDeliveryCode'],
        state: prepState
    );
    preparationsList.add(prep);
  }
  return preparationsList;
}

List<Preparation> getSamplePreparations() {
  return getPreparationsFromJson(sampleJsonPreparations);
}