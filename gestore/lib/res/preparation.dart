enum PreparationState { DELIVERED, TO_DELIVER, READY, UNDERWAY, WAITING }

/// preparations states are displayed to user as follows
extension PreparationStateStrings on PreparationState {
  String get str {
    switch (this) {
      case PreparationState.TO_DELIVER:
        return "Da servire";
      case PreparationState.DELIVERED:
        return "Servito";
      case PreparationState.READY:
        return "Pronto";
      case PreparationState.UNDERWAY:
        return "In preparazione";
      case PreparationState.WAITING:
        return "In attesa";
    }
  }
}

class Preparation {
  final int id;
  final String name;
  final String table;
  PreparationState state;

  Preparation(
      {required this.id,
      required this.name,
      required this.table,
      required this.state});

  factory Preparation.fromJson(Map<String, dynamic> json) {
    return Preparation(
      id: json['id'],
      name: json['name'],
      table: json['tableNum'],
      state: PreparationState.values.byName(json['state']),
    );
  }
  toString() =>
      "Preparation(id: $id, name: $name, table: $table, state: $state)";
}
