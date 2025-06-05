abstract class INotifier {

  void initializeNotifier(String key);

  void sendNotification(String name, [dynamic body, String type]);

}
