import 'package:puremvc/puremvc.dart';

class Facade implements IFacade {
  static const String MULTITON_MSG = "Facade instance for this Multiton key already constructed!";

  static Map<String, IFacade> instanceMap = {};

  late IController controller;
  late IModel model;
  late IView view;

  late String multitonKey;

  Facade(String key) {
    if (instanceMap.containsKey(key)) throw Exception(MULTITON_MSG);
    multitonKey = key;
    instanceMap[multitonKey] = this;
    initializeFacade();
  }

  void initializeFacade() {
    initializeModel();
    initializeController();
    initializeView();
  }

  void initializeController() {
    controller = Controller.getInstance(multitonKey, (k) => Controller(k));
  }

  void initializeModel() {
    model = Model.getInstance(multitonKey, (k) => Model(k));
  }

  void initializeView() {
    view = View.getInstance(multitonKey, (k) => View(k));
  }

  @override
  void executeCommand(INotification notification) {
    controller.executeCommand(notification);
  }

  @override
  void registerCommand(String notificationName, ICommand Function() factory) {
    controller.registerCommand(notificationName, factory);
  }

  @override
  bool hasCommand(String notificationName) {
    return controller.hasCommand(notificationName);
  }

  @override
  void removeCommand(String notificationName) {
    controller.removeCommand(notificationName);
  }

  @override
  void registerProxy(IProxy proxy) {
    model.registerProxy(proxy);
  }

  @override
  IProxy? retrieveProxy(String proxyName) {
    return model.retrieveProxy(proxyName);
  }

  @override
  bool hasProxy(String proxyName) {
    return model.hasProxy(proxyName);
  }

  @override
  IProxy? removeProxy(String proxyName) {
    return model.removeProxy(proxyName);
  }

  @override
  void registerObserver(String notificationName, IObserver observer) {
    view.registerObserver(notificationName, observer);
  }

  @override
  void notifyObservers(INotification notification) {
    view.notifyObservers(notification);
  }

  @override
  void removeObserver(String notificationName, Object notifyContext) {
    view.removeObserver(notificationName, notifyContext);
  }

  @override
  void registerMediator(IMediator mediator) {
    view.registerMediator(mediator);
  }

  @override
  IMediator? retrieveMediator(String mediatorName) {
    return view.retrieveMediator(mediatorName);
  }

  @override
  IMediator? removeMediator(String mediatorName) {
    return view.removeMediator(mediatorName);
  }

  @override
  bool hasMediator(String mediatorName) {
    return view.hasMediator(mediatorName);
  }

  @override
  void sendNotification(String name, [body, String type = ""]) {
    notifyObservers(Notification(name, body, type));
  }

  @override
  void initializeNotifier(String key) {
    multitonKey = key;
  }

  static IFacade getInstance(String key, IFacade Function(String) factory) {
    if (!instanceMap.containsKey(key)) {
      instanceMap[key] = factory(key);
    }
    return instanceMap[key]!;
  }

  static bool hasCore(String key) {
    return instanceMap.containsKey(key);
  }

  static void removeCore(String key) {
    if (!instanceMap.containsKey(key)) return;
    Model.removeModel(key);
    View.removeView(key);
    Controller.removeController(key);
    instanceMap.remove(key);
  }
}
