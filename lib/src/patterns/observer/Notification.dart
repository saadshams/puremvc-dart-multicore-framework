import 'package:puremvc/puremvc.dart';

class Notification implements INotification {
  final String _name;

  dynamic _body;

  String? _type;

  Notification(String name, [this._body, this._type]) : _name = name;

  @override
  String get name => _name;

  @override
  dynamic get body => _body;

  @override
  set body(dynamic value) {
    _body = value;
  }

  @override
  String? get type => _type;

  @override
  set type(String? value) {
    _type = value;
  }

  @override
  String toString() {
    return 'Notification(name: $_name, body: $_body, type: $_type)';
  }
}
