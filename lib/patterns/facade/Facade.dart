//
//  Facade.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// A base Multiton [IFacade] implementation.
///
/// The Facade Pattern suggests providing a single
/// class to act as a central point of communication
/// for a subsystem.
///
/// In PureMVC, the [IFacade] acts as an interface between
/// the core MVC actors [IModel], [IView], [IController], and
/// the rest of your application, which (aside from view components
/// and data objects) is mostly expressed with [ICommand]s,
/// [IMediator]s, and [IProxy]s.
///
/// This means you don't need to communicate with the [IModel],
/// [IView], [IController] instances directly, you can just go through
/// the [IFacade]. And conveniently, [ICommand]s, [IMediator]s, and
/// [IProxy]s all have a built-in reference to their [IFacade] after
/// initialization, so they're all plugged in and ready to communicate
/// with each other.
///
/// @see [Model], [View], [Controller], [INotification], [ICommand], [IMediator], [IProxy]
class Facade implements IFacade {
  /// Message Constants
  static const String MULTITON_MSG = "Facade instance for this Multiton key already constructed!";

  /// The [IFacade] Multiton instanceMap.
  static Map<String, IFacade> _instanceMap = {};

  /// This [IFacade]'s Multiton key
  late String _multitonKey;

  /// Reference to [IController]
  late IController _controller;

  /// Reference to [IModel]
  late IModel _model;

  /// Reference to [IView]
  late IView _view;

  /// Constructor.
  ///
  /// This [IFacade] implementation is a Multiton, so you should not call the constructor directly,
  /// but instead call the static [getInstance] method.
  ///
  /// @throws [Exception] if an instance for this Multiton key has already been constructed.
  Facade(String key) {
    if (_instanceMap.containsKey(key)) throw Exception(MULTITON_MSG);
    _multitonKey = key;
    _instanceMap[_multitonKey] = this;
    initializeFacade();
  }

  /// Initialize the Multiton [Facade] instance.
  ///
  /// Called automatically by the constructor. Override in your subclass to perform
  /// any subclass-specific initialization. Be sure to call [super.initializeFacade()]
  /// when overriding.
  void initializeFacade() {
    initializeModel();
    initializeController();
    initializeView();
  }

  /// Returns the [IFacade] Multiton instance associated with the given [key].
  ///
  /// If no instance exists for the given [key], the provided [factory] function
  /// is used to create one.
  /// @param key The unique Multiton key identifying the instance.
  /// @param factory A function that creates a new [IView] instance if one doesn't exist.
  /// @returns [IFacade] The Multiton instance associated with the given key.
  static IFacade getInstance(String key, IFacade Function(String) factory) {
    if (!_instanceMap.containsKey(key)) {
      _instanceMap[key] = factory(key);
    }
    return _instanceMap[key]!;
  }

  /// Initializes the [IController].
  ///
  /// Called by the [initializeFacade] method.
  ///
  /// Override this method in a subclass of [Facade] to provide a different [IController] implementation.
  void initializeController() {
    _controller = Controller.getInstance(_multitonKey, (k) => Controller(k));
  }

  /// Initializes the [IModel].
  ///
  /// Called by the [initializeFacade] method.
  ///
  /// Override this method in a subclass of [Facade] to provide a different [IModel] implementation.
  void initializeModel() {
    _model = Model.getInstance(_multitonKey, (k) => Model(k));
  }

  /// Initializes the [IView].
  ///
  /// Called by the [initializeFacade] method.
  ///
  /// Override this method in a subclass of [Facade] to provide a different [IView] implementation.
  void initializeView() {
    _view = View.getInstance(_multitonKey, (k) => View(k));
  }

  /// Registers an [INotification] to [ICommand] mapping with the [Controller].
  ///
  /// @param notificationName The name of the [INotification] to associate the [ICommand] with.
  /// @param factory A function that creates a new instance of the [ICommand].
  @override
  void registerCommand(String notificationName, ICommand Function() factory) {
    _controller.registerCommand(notificationName, factory);
  }

  /// Checks if an [ICommand] is registered for a given [INotification] name with the [IController].
  ///
  /// @param notificationName The name of the [INotification].
  /// @returns bool Whether an [ICommand] is currently registered for the given [noteName].
  @override
  bool hasCommand(String notificationName) {
    return _controller.hasCommand(notificationName);
  }

  /// Removes a previously registered [INotification] to [ICommand] mapping from the [IController].
  ///
  /// @param notificationName The name of the [INotification] to remove the [ICommand] mapping for.
  @override
  void removeCommand(String notificationName) {
    _controller.removeCommand(notificationName);
  }

  /// Registers an [IProxy] instance with the [IModel].
  ///
  /// @param proxy An object reference to be held by the [IModel].
  @override
  void registerProxy(IProxy proxy) {
    _model.registerProxy(proxy);
  }

  /// Retrieves an [IProxy] instance from the [IModel].
  ///
  /// @param proxyName The name of the [IProxy] instance to retrieve.
  /// @returns [IProxy] The instance previously registered with the given [proxyName].
  @override
  IProxy? retrieveProxy(String proxyName) {
    return _model.retrieveProxy(proxyName);
  }

  /// Checks if an [IProxy] is registered with the [IModel].
  ///
  /// @param proxyName The name of the [IProxy] instance you're looking for.
  /// @returns Whether an [IProxy] is currently registered with the given [proxyName].
  @override
  bool hasProxy(String proxyName) {
    return _model.hasProxy(proxyName);
  }

  /// Removes an [IProxy] instance from the [IModel].
  ///
  /// @param proxyName The name of the [IProxy] instance to be removed.
  /// @returns [IProxy] The proxy that was removed from the [IModel].
  @override
  IProxy? removeProxy(String proxyName) {
    return _model.removeProxy(proxyName);
  }

  /// Registers an [IMediator] instance with the [IView].
  ///
  /// Registers the [IMediator] so it can be retrieved by name,
  /// and interrogates the [IMediator] for its [INotification] interests.
  ///
  /// If the [IMediator] returns a list of [INotification] names to be notified about,
  /// an [Observer] is created encapsulating the [IMediator]'s [handleNotification] method,
  /// and registers it as an [IObserver] for all [INotification]s the [IMediator] is interested in.
  ///
  /// @param mediator A reference to the [IMediator] instance.
  @override
  void registerMediator(IMediator mediator) {
    _view.registerMediator(mediator);
  }

  /// Retrieves an [IMediator] from the [IView].
  ///
  /// @param mediatorName The name of the [IMediator] instance to retrieve.
  /// @returns [IMediator] The instance previously registered in this core with the given [mediatorName].
  @override
  IMediator? retrieveMediator(String mediatorName) {
    return _view.retrieveMediator(mediatorName);
  }

  /// Checks if a Mediator is registered.
  ///
  /// @param mediatorName The name of the [IMediator] to check.
  /// @returns Whether an [IMediator] is registered in this core with the given [mediatorName].
  @override
  bool hasMediator(String mediatorName) {
    return _view.hasMediator(mediatorName);
  }

  /// Removes an [IMediator] from the [IView].
  ///
  /// @param mediatorName The name of the [IMediator] instance to be removed.
  /// @returns [IMediator] The [IMediator] that was removed from this core's [IView].
  @override
  IMediator? removeMediator(String mediatorName) {
    return _view.removeMediator(mediatorName);
  }

  /// Initializes this [INotifier].
  ///
  /// This is how an [INotifier] gets its [multitonKey].
  /// Calls to [sendNotification] or access to the [facade]
  /// will fail until after this method has been called.
  ///
  /// @param key The [multitonKey] for this [INotifier] to use.
  @override
  void initializeNotifier(String key) {
    _multitonKey = key;
  }

  /// Registers an [IObserver] to be notified of [INotification]s with a specified name.
  ///
  /// @param notificationName The name of the [INotification] to notify this [IObserver] of.
  /// @param observer The [IObserver] to register.
  void registerObserver(String notificationName, IObserver observer) {
    _view.registerObserver(notificationName, observer);
  }

  /// Notifies [IObserver]s with the given [INotification].
  ///
  /// This method allows sending custom [INotification] instances using the [IFacade].
  ///
  /// Typically, you should call [sendNotification] with parameters,
  /// without needing to construct an [INotification] manually.
  ///
  /// @param notification The [INotification] to notify [IObserver]s of.
  @override
  void notifyObservers(INotification notification) {
    _view.notifyObservers(notification);
  }

  /// Removes an [IObserver] from the list for a given [INotification] name.
  ///
  /// @param notificationName The name of the [INotification] observer list to remove from.
  /// @param notifyContext Remove [IObserver]s whose notifyContext matches this object.
  void removeObserver(String notificationName, Object notifyContext) {
    _view.removeObserver(notificationName, notifyContext);
  }

  /// Sends an [INotification].
  ///
  /// Convenience method to avoid constructing new [INotification] instances manually.
  ///
  /// @param name The name of the notification to send.
  /// @param body The body of the notification (optional).
  /// @param type The type of the notification (optional).
  @override
  void sendNotification(String name, [body, String type = ""]) {
    notifyObservers(Notification(name, body, type));
  }

  /// Checks if a Core is registered or not.
  ///
  /// @param key The Multiton key for the Core.
  /// @returns [bool] Whether a Core is registered with the given [key].
  static bool hasCore(String key) {
    return _instanceMap.containsKey(key);
  }

  /// Removes a Core.
  ///
  /// Removes the [IModel], [IView], [IController], and [IFacade]
  /// instances associated with the given key.
  ///
  /// @param key The Multiton key of the Core to remove.
  static void removeCore(String key) {
    if (!_instanceMap.containsKey(key)) return;
    Model.removeModel(key);
    View.removeView(key);
    Controller.removeController(key);
    _instanceMap.remove(key);
  }

}
