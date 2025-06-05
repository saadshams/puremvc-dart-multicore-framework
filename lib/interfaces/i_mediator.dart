//
//  i_mediator.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// The interface definition for a PureMVC MultiCore Mediator.
///
/// In PureMVC, [IMediator] implementors assume these responsibilities:
///
/// - Implement a common method which returns a list of all [INotification]s the [IMediator] has interest in.
/// - Implement a notification (callback) method for handling [INotification]s.
/// - Implement methods that are called when the [IMediator] is registered or removed from an [IView].
///
/// Additionally, [IMediator]s typically:
///
/// - Act as an intermediary between one or more view components and the rest of the application.
/// - Place [Event] listeners on view components, and implement handlers which often send [INotification]s or interact with [IProxy]s to post or retrieve data.
/// - Receive [INotification]s, typically containing data, and update view components in response.
///
/// When an [IMediator] is registered with the [IView], the [IMediator]'s [listNotificationInterests] method is called.
/// The [IMediator] will return a [List] of [INotification] names which it wishes to be notified about.
///
/// The [IView] will then create an [IObserver] object encapsulating that [IMediator] and its [handleNotification] method,
/// and register the [IObserver] for each [INotification] name returned by the [IMediator]'s [listNotificationInterests] method.
///
/// See also:
/// - [INotification]
/// - [IView]
abstract class IMediator extends INotifier {

  /// Called by the [IView] when this [IMediator] is registered.
  void onRegister();

  /// Called by the [IView] when this [IMediator] is removed.
  void onRemove();

  /// Returns a list of notification names this [IMediator] is interested in.
  ///
  /// @returns List<String> the names of notifications.
  List<String> listNotificationInterests();

  /// Handles a notification.
  ///
  /// @param notification the notification to handle.
  void handleNotification(INotification notification);

  /// This [IMediator]'s [name].
  String get name;

  /// This [IMediator]'s [view].
  dynamic get view;
  set view(dynamic value);

}
