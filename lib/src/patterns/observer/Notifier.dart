import 'package:puremvc/puremvc.dart';

class Notifier implements INotifier {
  late String _multitonKey;

  @override
  void initializeNotifier(String key) {
    _multitonKey = key;
  }

  @override
  void sendNotification(String name, [body, String type = ""]) {
    facade.sendNotification(name, body, type);
  }

  IFacade get facade {
    return Facade.getInstance(_multitonKey, (k) => Facade(k));
  }

  String get multitonKey => _multitonKey;

  set multitonKey(String value) {
    _multitonKey = value;
  }
}
