import 'package:puremvc/puremvc.dart';

class Mediator extends Notifier implements IMediator {
  static const NAME = "Mediator";

  final String _name;

  dynamic _viewComponent;

  Mediator([String? name, this._viewComponent]) : _name = name ?? NAME;

  @override
  void onRegister() {}

  @override
  void onRemove() {}

  @override
  List<String> listNotificationInterests() {
    return [];
  }

  @override
  void handleNotification(INotification notification) {}

  @override
  String get name => _name;

  @override
  dynamic get viewComponent => _viewComponent;

  @override
  set viewComponent(dynamic value) {
    _viewComponent = value;
  }
}
