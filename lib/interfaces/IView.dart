import 'package:puremvc/puremvc.dart';

abstract class IView {
  void registerObserver(String notificationName, IObserver observer);

  void notifyObservers(INotification notification);

  void removeObserver(String notificationName, Object notifyContext);

  void registerMediator(IMediator mediator);

  IMediator? retrieveMediator(String mediatorName);

  IMediator? removeMediator(String mediatorName);

  bool hasMediator(String mediatorName);
}
