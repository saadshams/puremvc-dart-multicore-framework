import 'package:puremvc/puremvc.dart';

abstract class IObserver {
  void notifyObserver(INotification notification);

  bool compareNotifyContext(Object object);

  void Function(INotification)? get notify;

  set notify(void Function(INotification)? value);

  Object? get context;

  set context(Object? value);
}
