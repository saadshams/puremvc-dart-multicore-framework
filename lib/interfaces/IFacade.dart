//
//  IFacade.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// The interface definition for a PureMVC MultiCore Facade.
///
/// The Facade Pattern provides a single class that acts as a central point of communication
/// for a subsystem.
///
/// In PureMVC, the [IFacade] serves as an interface between the core MVC actors:
/// [IModel], [IView], [IController], and the rest of your application.
/// Most of your app logic—aside from view components and data objects—will use
/// [ICommand]s, [IMediator]s, and [IProxy]s, all of which have access to the [IFacade].
///
/// This allows decoupled communication and centralized coordination.
///
/// See also: [IModel], [IView], [IController], [IProxy], [IMediator], [ICommand], [INotification]
abstract class IFacade implements INotifier {

  /// Registers an [ICommand] to handle a specific [INotification] name.
  ///
  /// @param notificationName The name of the [INotification].
  /// @param factory A factory function that returns a new [ICommand] instance.
  void registerCommand(String notificationName, ICommand Function() factory);

  /// Checks if a command is registered for the given notification name.
  ///
  /// @param noteName The [INotification] name to check.
  /// @returns Whether the command is registered.
  bool hasCommand(String notificationName);

  /// Removes an [ICommand] previously registered for a notification name.
  ///
  /// @param notificationName The name of the [INotification].
  void removeCommand(String notificationName);

  /// Registers an [IProxy] instance with the [IModel].
  ///
  /// @param proxy The [IProxy] to register.
  void registerProxy(IProxy proxy);

  /// Retrieves an [IProxy] instance from the [IModel].
  ///
  /// @param proxyName The name of the [IProxy] to retrieve.
  /// @returns [IProxy] The instance previously registered with the given name.
  IProxy? retrieveProxy(String proxyName);

  /// Checks whether an [IProxy] is registered.
  ///
  /// @param proxyName The name of the [IProxy].
  /// @returns Whether if a proxy with the given name is registered.
  bool hasProxy(String proxyName);

  /// Removes an [IProxy] from the [IModel].
  ///
  /// @param proxyName The name of the [IProxy] to remove.
  /// @returns [IProxy] The instance that was removed.
  IProxy? removeProxy(String proxyName);

  /// Registers an [IMediator] instance with the [IView].
  ///
  /// The mediator is interrogated for its [INotification] interests and registered accordingly.
  ///
  /// @param mediator The [IMediator] instance to register.
  void registerMediator(IMediator mediator);

  /// Retrieves an [IMediator] instance from the [IView].
  ///
  /// @param mediatorName The name of the [IMediator] to retrieve.
  /// @returns [IMediator] The instance if registered, or `null` if not.
  IMediator? retrieveMediator(String mediatorName);

  /// Removes an [IMediator] instance from the [IView].
  ///
  /// @param mediatorName The name of the [IMediator] to remove.
  /// @returns [IMediator] The removed instance, or `null` if not found.
  IMediator? removeMediator(String mediatorName);

  /// Checks whether an [IMediator] is registered.
  ///
  /// @param mediatorName The name of the [IMediator] to check.
  /// @returns Whether the mediator is registered.
  bool hasMediator(String mediatorName);

  /// Registers an [IObserver] for a given [INotification] name.
  ///
  /// @param notificationName The name of the notification.
  /// @param observer The observer to notify.
  void registerObserver(String notificationName, IObserver observer);

  /// Notifies all [IObserver]s registered for the given [INotification].
  ///
  /// @param notification The notification to broadcast.
  void notifyObservers(INotification notification);

  /// Removes [IObserver]s with a specific context for a given notification name.
  ///
  /// @param notificationName The name of the notification.
  /// @param notifyContext The context used to match observers for removal.
  void removeObserver(String notificationName, Object notifyContext);

}
