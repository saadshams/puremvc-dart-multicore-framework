//
//  INotification.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

/// The interface definition for a PureMVC MultiCore notification.
///
/// The Observer pattern, as implemented within PureMVC, supports publish/subscribe
/// communication between actors.
///
/// `INotification` is not intended to replace platform-specific `Event` classes,
/// but serves as an internal messaging mechanism to ensure portability of PureMVC
/// across platforms, regardless of whether a native event system is available.
///
/// Typically, `IMediator` implementors listen for events from their view components,
/// and `IProxy` implementors listen for events from service components. These events
/// are handled in the usual way and may result in the broadcast of `INotification`
/// instances, which in turn trigger `ICommand`s or notify other `IMediator`s.
///
/// See also: [IView], [IObserver].
abstract class INotification {
  /// This [INotifications]'s [name]
  String get name;

  /// This [INotifications]'s [body]
  dynamic get body;
  set body(dynamic value);

  /// This [INotifications]'s [type]
  String get type;
  set type(String value);
}
