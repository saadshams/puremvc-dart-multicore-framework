//
//  i_view.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// The interface definition for a PureMVC MultiCore View.
///
/// In PureMVC, [IView] implementors assume these responsibilities:
///
/// - Maintain a cache of [IMediator] instances.
/// - Provide methods for registering, retrieving, and removing [IMediator]s.
/// - Manage the [IObserver] lists for each [INotification].
/// - Provide a method for attaching [IObserver]s to an [INotification]'s [IObserver] list.
/// - Provide a method for broadcasting an [INotification] to each of the [IObserver]s in a list.
/// - Notify the [IObservers] of a given [INotification] when it is broadcast.
///
/// See [IMediator], [IObserver], [INotification].
abstract class IView {

  /// Register an [IObserver] to be notified of [INotification]s with a given name.
  ///
  /// @param [notificationName] The name of the [INotification] to notify this [IObserver] of.
  /// @param [observer] The [IObserver] to register.
  void registerObserver(String notificationName, IObserver observer);

  /// Notify the [IObserver]s for a particular [INotification].
  ///
  /// All previously attached [IObserver]s for this [INotification]'s list are notified
  /// and are passed a reference to the [INotification] in the order they were registered.
  ///
  /// @param [notification] The [INotification] to notify [IObserver]s of.
  void notifyObservers(INotification notification);

  /// Remove an [IObserver] from the list for a given [INotification] name.
  ///
  /// @param [notificationName] The [INotification] name whose observer list to remove from.
  /// @param [notifyContext] Remove [IObserver]s with this object as the [notifyContext].
  void removeObserver(String notificationName, Object notifyContext);

  /// Register an [IMediator] instance with the [IView].
  ///
  /// Registers the [IMediator] so that it can be retrieved by name,
  /// and interrogates the [IMediator] for its [INotification] interests.
  ///
  /// If the [IMediator] returns a list of [INotification] names to be notified about,
  /// an [IObserver] is created encapsulating the [IMediator] instance's
  /// [handleNotification] method and registered as an observer for all
  /// [INotification]s the [IMediator] is interested in.
  ///
  /// @param [mediator] A reference to the [IMediator] instance.
  void registerMediator(IMediator mediator);

  /// Retrieve an [IMediator] from the [IView].
  ///
  /// @param [mediatorName] The name of the [IMediator] instance to retrieve.
  /// @returns [IMediator] The instance previously registered with the given [mediatorName].
  IMediator? retrieveMediator(String mediatorName);

  /// Check if an [IMediator] is registered with the [IView].
  ///
  /// @param [mediatorName] The name of the [IMediator] to look for.
  /// @returns Whether an [IMediator] is registered with the given [mediatorName].
  bool hasMediator(String mediatorName);

  /// Remove an [IMediator] from the [IView].
  ///
  /// @param [mediatorName] The name of the [IMediator] instance to be removed.
  /// @returns [IMediator] The mediator that was removed from this core's [IView].
  IMediator? removeMediator(String mediatorName);
}
