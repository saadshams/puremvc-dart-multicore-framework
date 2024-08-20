abstract class INotifier {
  void sendNotification(String name, [dynamic body, String type]);

  void initializeNotifier(String key);
}
