import 'package:puremvc/puremvc.dart';

class Observer implements IObserver {
  void Function(INotification) _notify;

  Object _context;

  Observer(this._notify, this._context);

  @override
  void notifyObserver(INotification notification) {
    _notify.call(notification);
  }

  @override
  bool compareNotifyContext(Object object) {
    return identical(_context, object);
  }

  @override
  set notify(void Function(INotification) value) {
    _notify = value;
  }

  @override
  set context(Object value) {
    _context = value;
  }
}
