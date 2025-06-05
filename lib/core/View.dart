import 'package:puremvc/puremvc.dart';

class View implements IView {
  static const String MULTITON_MSG = "View instance for this Multiton key already constructed!";

  static Map<String, IView> instanceMap = {};

  late String multitonKey;

  late Map<String, IMediator> mediatorMap;

  late Map<String, List<IObserver>> observerMap;

  View(String key) {
    if (instanceMap.containsKey(key)) throw Exception(MULTITON_MSG);
    multitonKey = key;
    instanceMap[multitonKey] = this;
    mediatorMap = {};
    observerMap = {};
    initializeView();
  }

  void initializeView() {}

  @override
  void registerObserver(String notificationName, IObserver observer) {
    if (!observerMap.containsKey(notificationName)) {
      observerMap[notificationName] = [];
    }
    observerMap[notificationName]!.add(observer);
  }

  @override
  void notifyObservers(INotification notification) {
    List<IObserver>? observersRef = observerMap[notification.name];
    if (observersRef == null) return;

    List<IObserver> observers = List<IObserver>.from(observersRef);
    for (var i = 0; i < observers.length; i++) {
      observers[i].notifyObserver(notification);
    }
  }

  @override
  void removeObserver(String notificationName, Object notifyContext) {
    final observers = observerMap[notificationName];
    if (observers == null) return;
    for (var i = 0; i < observers.length; i++) {
      if (observers[i].compareNotifyContext(notifyContext)) {
        observers.removeAt(i);
        break;
      }
    }

    if (observers.isEmpty) {
      observerMap.remove(notificationName);
    }
  }

  @override
  void registerMediator(IMediator mediator) {
    if (mediatorMap.containsKey(mediator.mediatorName)) return;

    mediator.initializeNotifier(multitonKey);

    mediatorMap[mediator.mediatorName] = mediator;

    final interests = mediator.listNotificationInterests();
    if (interests.isNotEmpty) {
      final observer = Observer(mediator.handleNotification, mediator);
      for (var i = 0; i < interests.length; i++) {
        registerObserver(interests[i], observer);
      }
    }

    mediator.onRegister();
  }

  @override
  IMediator? retrieveMediator(String mediatorName) {
    return mediatorMap[mediatorName];
  }

  @override
  IMediator? removeMediator(String mediatorName) {
    final mediator = mediatorMap[mediatorName];
    if (mediator == null) return null;

    List<String> interests = mediator.listNotificationInterests();
    for (var i = 0; i < interests.length; i++) {
      removeObserver(interests[i], mediator);
    }

    mediatorMap.remove(mediatorName);
    mediator.onRemove();
    return mediator;
  }

  @override
  bool hasMediator(String mediatorName) {
    return mediatorMap.containsKey(mediatorName);
  }

  static IView getInstance(String key, IView Function(String) factory) {
    if (!instanceMap.containsKey(key)) {
      instanceMap[key] = factory(key);
    }
    return instanceMap[key]!;
  }

  static removeView(String key) {
    instanceMap.remove(key);
  }
}
