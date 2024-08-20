import 'package:puremvc/puremvc.dart';

class Mediator extends Notifier implements IMediator {
  static const NAME = "Mediator";

  final String _mediatorName;

  dynamic _viewComponent;

  Mediator([String? mediatorName, this._viewComponent]) : _mediatorName = mediatorName ?? NAME;

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
  String get mediatorName => _mediatorName;

  @override
  dynamic get viewComponent => _viewComponent;

  @override
  set viewComponent(dynamic value) {
    _viewComponent = value;
  }
}
