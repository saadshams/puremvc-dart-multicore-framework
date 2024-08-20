import 'package:puremvc/puremvc.dart';

abstract class IMediator extends INotifier {
  void onRegister();

  void onRemove();

  List<String> listNotificationInterests();

  void handleNotification(INotification notification);

  String get mediatorName;

  dynamic get viewComponent;

  set viewComponent(dynamic value);
}
