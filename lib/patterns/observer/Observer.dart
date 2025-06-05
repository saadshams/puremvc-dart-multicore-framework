//
//  Observer.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// A base [IObserver] implementation.
///
/// [IObserver] implementors:
/// - Encapsulate the notification (callback) method of the interested object.
/// - Encapsulate the notification context (this) of the interested object.
/// - Provide methods to set the notification method and context.
/// - Provide a method to notify the interested object.
///
/// This Observer Pattern supports publish/subscribe communication.
///
/// An [IObserver] holds info about an interested object and its callback,
/// called when an [INotification] is broadcast.
///
/// [IObserver]s receive [INotification]s via [notifyObserver].
///
/// See [IView], [INotification].
class Observer implements IObserver {

  void Function(INotification) _notify;

  Object _context;

  /// Constructor.
  ///
  /// The notify method should accept one parameter of type [INotification].
  ///
  /// @param notify The callback method.
  /// @param context The caller object.
  Observer(this._notify, this._context);

  /// Notify the interested object.
  ///
  /// @param note The [INotification] passed to the caller's [notifyMethod].
  @override
  void notifyObserver(INotification notification) {
    _notify.call(notification);
  }

  /// Compare a given object to the [notifyContext] (caller) object.
  ///
  /// @param object The object to compare.
  /// @returns [bool] True if the given object and the [notifyContext] (caller) are the same.
  @override
  bool compareNotifyContext(Object object) {
    return identical(_context, object);
  }

  /// This [IObserver]'s [notifyMethod] (i.e., callback)
  @override
  set notify(void Function(INotification) value) => _notify = value;

  /// This [IObserver]'s [notifyContext] (i.e., caller)
  @override
  set context(Object value) => _context = value;

}
