//
//  i_observer.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// The interface definition for a PureMVC MultiCore Observer.
///
/// In PureMVC, [IObserver] implementations assume these responsibilities:
///
/// - Encapsulate the notification callback method of the interested object.
/// - Encapsulate the notification context of the interested object.
/// - Provide methods for setting the notification method and context.
/// - Provide a method for notifying the interested object.
///
/// The Observer Pattern, as implemented in PureMVC, supports
/// publish/subscribe communication between actors.
///
/// An [IObserver] encapsulates information about an interested object
/// and its callback method that should be invoked when an [INotification]
/// is broadcast. It acts as a conduit for delivering notifications to the target.
///
/// Instances of [IObserver] receive notifications via [notifyObserver],
/// which accepts an [INotification].
///
/// See also: [IView], [INotification]
abstract class IObserver {

  /// Notifies the interested object.
  ///
  /// @param notification The [INotification] to pass to the caller's notify method.
  void notifyObserver(INotification notification);

  /// Compares the given object to the notify context (caller).
  ///
  /// @param object The object to compare with the notify context.
  /// @returns Whether the given object and the notify context are the same.
  bool compareNotifyContext(Object object);

  /// This [IObserver]'s [notifyMethod] (i.e., callback)
  set notify(void Function(INotification) value);

  /// This [IObserver]'s [notifyContext] (i.e., caller)
  set context(Object value);
}
