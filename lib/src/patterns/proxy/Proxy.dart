import 'package:puremvc/puremvc.dart';

class Proxy extends Notifier implements IProxy {
  static const NAME = "Proxy";

  final String _proxyName;

  dynamic _data;

  Proxy([String? proxyName, this._data]) : _proxyName = proxyName ??= NAME;

  @override
  void onRegister() {}

  @override
  void onRemove() {}

  @override
  String get proxyName => _proxyName;

  @override
  dynamic get data => _data;

  @override
  set data(dynamic value) {
    _data = value;
  }
}
