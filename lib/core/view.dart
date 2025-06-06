//
//  view.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// A PureMVC MultiCore [IView] implementation.
///
/// In PureMVC, [IView] implementors assume these responsibilities:
///
/// - Maintaining a cache of [IMediator] instances.
/// - Providing methods for registering, retrieving, and removing [IMediator]s.
/// - Managing the [IObserver] lists for each [INotification].
/// - Attaching [IObserver]s to an [INotification]'s observer list.
/// - Broadcasting an [INotification] to each of the [IObserver]s in a list.
/// - Notifying the [IObservers] of a given [INotification] when it is broadcast.
///
/// @see [IMediator], [IObserver], [INotification]
class View implements IView {
  /// Message Constants
  static const String MULTITON_MSG = "View instance for this Multiton key already constructed!";

  /// The [IView] Multiton instance map
  static Map<String, IView> _instanceMap = {};

  /// The Multiton key for this Core
  late String _multitonKey;

  /// Mapping of IMediator names to IMediator instances
  late Map<String, IMediator> _mediatorMap;

  /// Mapping of INotification names to IObserver lists
  late Map<String, List<IObserver>> _observerMap;

  /// Constructor.
  ///
  /// This [IView] implementation is a Multiton, so you should not call the constructor directly,
  /// but instead use the static [getInstance] method.
  ///
  /// @param key The multiton key for this instance.
  /// @throws [Exception] if an instance for this Multiton key has already been constructed.
  View(String key) {
    if (_instanceMap.containsKey(key)) throw Exception(MULTITON_MSG);
    _multitonKey = key;
    _instanceMap[_multitonKey] = this;
    _mediatorMap = {};
    _observerMap = {};
    initializeView();
  }

  /// Initialize the Multiton View instance.
  ///
  /// Called automatically by the constructor, this is your opportunity to initialize
  /// the Multiton instance in your subclass without overriding the constructor.
  void initializeView() {

  }

  /// [IView] Multiton factory method.
  ///
  /// @param key The unique Multiton key identifying the instance.
  /// @param factory A function that creates a new [IView] instance if one doesn't exist.
  /// @returns [IView] The Multiton instance associated with the given key.
  static IView getInstance(String key, IView Function(String) factory) {
    if (!_instanceMap.containsKey(key)) {
      _instanceMap[key] = factory(key);
    }
    return _instanceMap[key]!;
  }

  /// Register an [IObserver] to be notified of [INotification]s with a given name.
  ///
  /// @param notificationName The name of the [INotification] to notify this [IObserver] of.
  /// @param observer The [IObserver] to register.
  @override
  void registerObserver(String notificationName, IObserver observer) {
    if (!_observerMap.containsKey(notificationName)) {
      _observerMap[notificationName] = [];
    }
    _observerMap[notificationName]!.add(observer);
  }

  /// Notify the [IObserver]s for a particular [INotification].
  ///
  /// All previously attached [IObserver]s for this [INotification]'s list
  /// are notified and receive a reference to the [INotification] in the
  /// order they were registered.
  ///
  /// @param notification The [INotification] to notify [IObserver]s of.
  @override
  void notifyObservers(INotification notification) {
    List<IObserver>? observersRef = _observerMap[notification.name];
    if (observersRef == null) return;

    List<IObserver> observers = List<IObserver>.from(observersRef);
    for (final observer in observers) {
      observer.notifyObserver(notification);
    }
  }

  /// Remove an [IObserver] from the list for a given [INotification] name.
  ///
  /// @param notificationName The name of the [INotification] whose observer list to remove from.
  /// @param notifyContext The [notifyContext] to match for removing the [IObserver].
  @override
  void removeObserver(String notificationName, Object notifyContext) {
    List<IObserver>? observers = _observerMap[notificationName];
    if (observers == null) return;

    for (var i = 0; i < observers.length; i++) {
      if (observers[i].compareNotifyContext(notifyContext)) {
        observers.removeAt(i);
        break;
      }
    }

    if (observers.isEmpty) {
      _observerMap.remove(notificationName);
    }
  }

  /// Registers an [IMediator] instance with the [IView].
  ///
  /// Registers the [IMediator] so it can be retrieved by name,
  /// and queries the [IMediator] for its [INotification] interests.
  ///
  /// If the [IMediator] returns a list of [INotification] names,
  /// an [Observer] is created wrapping the [IMediator]'s
  /// [handleNotification] method and registered as an [IObserver]
  /// for each notification of interest.
  ///
  /// @param mediator The [IMediator] instance to register.
  @override
  void registerMediator(IMediator mediator) {
    if (_mediatorMap.containsKey(mediator.name)) return;

    mediator.initializeNotifier(_multitonKey);

    _mediatorMap[mediator.name] = mediator;

    List<String> interests = mediator.listNotificationInterests();
    if (interests.isNotEmpty) {
      IObserver observer = Observer(mediator.handleNotification, mediator);
      for (var i = 0; i < interests.length; i++) {
        registerObserver(interests[i], observer);
      }
    }

    mediator.onRegister();
  }

  /// Retrieves an [IMediator] from the [IView].
  ///
  /// @param mediatorName The name of the [IMediator] instance to retrieve.
  /// @returns The [IMediator] instance previously registered with the given [mediatorName].
  @override
  IMediator? retrieveMediator(String mediatorName) {
    return _mediatorMap[mediatorName];
  }

  /// Checks if an [IMediator] is registered with the [IView].
  ///
  /// @param mediatorName The name of the [IMediator] to check for.
  /// @returns `true` if an [IMediator] with the given [mediatorName] is registered; otherwise, `false`.
  @override
  bool hasMediator(String mediatorName) {
    return _mediatorMap.containsKey(mediatorName);
  }

  /// Removes an [IMediator] from the [IView].
  ///
  /// @param mediatorName The name of the [IMediator] instance to remove.
  /// @returns [IMediator] The instance that was removed, or `null` if none was found.
  @override
  IMediator? removeMediator(String mediatorName) {
    IMediator? mediator = _mediatorMap[mediatorName];
    if (mediator == null) return null;

    List<String> interests = mediator.listNotificationInterests();
    for (var i = 0; i < interests.length; i++) {
      removeObserver(interests[i], mediator);
    }

    _mediatorMap.remove(mediatorName);
    mediator.onRemove();
    return mediator;
  }

  /// Removes an [IView] Multiton instance.
  ///
  /// @param key The Multiton key of the [IView] instance to remove.
  static removeView(String key) {
    _instanceMap.remove(key);
  }

}
