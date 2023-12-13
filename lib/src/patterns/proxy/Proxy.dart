import 'package:puremvc/puremvc.dart';

class Proxy extends Notifier implements IProxy {
  static const NAME = "Proxy";

  final String _name;

  dynamic _data;

  Proxy([String? name, this._data]) : _name = name ??= NAME;

  @override
  void onRegister() {}

  @override
  void onRemove() {}

  @override
  String get name => _name;

  @override
  dynamic get data => _data;

  @override
  set data(dynamic value) {
    _data = value;
  }
}
