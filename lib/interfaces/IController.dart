import '../../puremvc.dart';

abstract class IController {
  void executeCommand(INotification notification);

  void registerCommand(String notificationName, ICommand Function() factory);

  bool hasCommand(String notificationName);

  void removeCommand(String notificationName);
}
