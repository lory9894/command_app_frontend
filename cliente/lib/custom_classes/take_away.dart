import 'order.dart';

class TakeAway {
  String? _address, _notes;
  late final Order _order;
  TakeAway(this._address, this._notes, this._order);

  Order get order => _order;

  get notes => _notes;

  set notes(value) {
    _notes = value;
  }

  String get address => _address!;

  set address(String value) {
    _address = value;
  }
}
