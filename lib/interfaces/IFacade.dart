import 'package:puremvc/puremvc.dart';

abstract class IFacade implements INotifier {

  void executeCommand(INotification notification);

  void registerCommand(String notificationName, ICommand Function() factory);

  bool hasCommand(String notificationName);

  void removeCommand(String notificationName);

  void registerProxy(IProxy proxy);

  IProxy? retrieveProxy(String proxyName);

  bool hasProxy(String proxyName);

  IProxy? removeProxy(String proxyName);

  void registerMediator(IMediator mediator);

  IMediator? retrieveMediator(String mediatorName);

  IMediator? removeMediator(String mediatorName);

  bool hasMediator(String mediatorName);

  void notifyObservers(INotification notification);

}
