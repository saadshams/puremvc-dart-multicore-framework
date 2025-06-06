//
//  controller.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// A PureMVC MultiCore [IController] implementation.
///
/// In PureMVC, an [IController] implementor follows the 'Command and Controller'
/// strategy, and assumes these responsibilities:
///
/// - Remembering which [ICommand]s are intended to handle which [INotification]s.
/// - Registering itself as an [IObserver] with the [View] for each [INotification]
///   that it has an [ICommand] mapping for.
/// - Creating a new instance of the proper [ICommand] to handle a given
///   [INotification] when notified by the [IView].
/// - Calling the [ICommand]'s [execute] method, passing in the [INotification].
///
/// See also: [INotification], [ICommand]
class Controller implements IController {
  /// Message Constants
  static const String MULTITON_MSG = "Controller instance for this Multiton key already constructed!";

  /// The [IController] Multiton instance map
  static Map<String, IController> _instanceMap = {};

  /// The Multiton Key for this Core
  late String _multitonKey;
  
  /// Mapping of Notification names to Command factories
  late Map<String, ICommand Function()> _commandMap;

  /// Local reference to this core's IView
  late IView _view;

  /// Constructor.
  ///
  /// This [IController] implementation is a Multiton, so you should not call the
  /// constructor directly. Instead, use the static [getInstance] method.
  ///
  /// @param key The unique Multiton key for this instance.
  /// @throws [Exception] if an instance for this Multiton key has already been constructed.
  Controller(String key) {
    if (_instanceMap.containsKey(key)) throw Exception(MULTITON_MSG);
    _multitonKey = key;
    _instanceMap[_multitonKey] = this;
    _commandMap = {};
    initializeController();
  }

  /// Initialize the [IController] Multiton instance.
  ///
  /// Called automatically by the constructor.
  /// If you are using a custom [IView] implementor in your application,
  /// you should subclass [Controller] and override the [initializeController] method,
  /// setting [_view] equal to the return value of a call to [getInstance]
  /// on your [IView] implementor.
  initializeController() {
    _view = View.getInstance(_multitonKey, (k) => View(k));
  }

  /// [IController] Multiton factory method.
  ///
  /// Returns the [IController] Multiton instance for the specified key.
  ///
  /// @param key The unique key identifying the Multiton instance.
  /// @param factory A function that creates a new [IController] instance.
  ///
  /// @returns [IController] The Multiton instance associated with the given key.
  static IController getInstance(String key, IController Function(String) factory) {
    if (!_instanceMap.containsKey(key)) {
      _instanceMap[key] = factory(key);
    }
    return _instanceMap[key]!;
  }

  /// Execute the [ICommand] previously registered as the
  /// handler for [INotification]s with the given notification's name.
  ///
  /// @param notification The notification to execute the associated [ICommand] for.
  @override
  void executeCommand(INotification notification) {
    ICommand Function()? factory = _commandMap[notification.name];
    if (factory == null) return;

    ICommand command = factory();
    command.initializeNotifier(_multitonKey);
    command.execute(notification);
  }

  /// Register an [INotification] to [ICommand] mapping with the [Controller].
  ///
  /// @param notificationName The name of the [INotification] to associate the [ICommand] with.
  /// @param factory A function that creates a new instance of the [ICommand].
  @override
  void registerCommand(String notificationName, ICommand Function() factory) {
    if (!_commandMap.containsKey(notificationName)) {
      _view.registerObserver(notificationName, Observer(executeCommand, this));
    }
    _commandMap[notificationName] = factory;
  }

  /// Check if an [ICommand] is registered for a given [INotification] name with the [IController].
  ///
  /// @param notificationName The name of the [INotification].
  /// @returns bool Whether an [ICommand] is currently registered for the given [noteName].=
  @override
  bool hasCommand(String notificationName) {
    return _commandMap.containsKey(notificationName);
  }

  /// Remove a previously registered [INotification] to [ICommand] mapping from the [IController].
  ///
  /// @param notificationName The name of the [INotification] to remove the [ICommand] mapping for.
  @override
  void removeCommand(String notificationName) {
    // if the Command is registered...
    if (_commandMap.containsKey(notificationName)) {
      // remove the observer
      _view.removeObserver(notificationName, this);
    }
    // remove the command
    _commandMap.remove(notificationName);
  }

  /// Remove an [IController] instance.
  ///
  /// @param key The multitonKey of the [IController] instance to remove.
  static void removeController(String key) {
    _instanceMap.remove(key);
  }

}
