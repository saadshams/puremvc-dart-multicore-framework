import 'package:puremvc/puremvc.dart';

abstract class IObserver {
  void notifyObserver(INotification notification);

  bool compareNotifyContext(Object object);

  set notify(void Function(INotification) value);

  set context(Object value);
}
