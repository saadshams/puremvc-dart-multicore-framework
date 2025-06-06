//
//  notification.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// A base [INotification] implementation.
///
/// PureMVC does not rely on underlying event models such as the one provided
/// with Flash, and Dart does not have an inherent event model.
///
/// The Observer Pattern as implemented within PureMVC exists to support
/// event-driven communication between the application and the actors of the
/// MVC triad.
///
/// Notifications are not meant to replace platform-native events. Generally,
/// [IMediator] implementors attach event listeners to their view components,
/// handle those events as usual, and then may broadcast [Notification]s to
/// trigger [ICommand]s or communicate with other [IMediator]s. [IProxy] and
/// [ICommand] instances communicate with each other and with [IMediator]s
/// through [INotification]s.
///
/// A key difference between native events (e.g., Flash's [Event]) and PureMVC
/// [Notification]s is that native events follow the 'Chain of Responsibility'
/// pattern and bubble up the UI hierarchy, while PureMVC [Notification]s follow
/// a 'Publish/Subscribe' pattern. PureMVC classes do not need to be in a
/// parent/child relationship to communicate via [Notification]s.
///
/// See also: [Observer]
class Notification implements INotification {

  // This [INotifications]'s [name]
  final String _name;

  // This [INotifications]'s [body]
  dynamic _body;

  // This [INotifications]'s [type]
  String _type = "";

  /// Creates a [Notification] instance.
  ///
  /// The [name] parameter is required and represents the name of the notification.
  /// The [body] and [type] parameters are optional and represent the notification’s
  /// payload and category/type respectively.
  ///
  /// - [name]: Name of the [Notification] instance (required)
  /// - [body]: The payload of the [Notification] (optional)
  /// - [type]: The type/category of the [Notification] (optional)
  Notification(String name, [dynamic body, String type = ""]): _name = name {
    _body = body;
    _type = type;
  }

  @override
  String get name => _name;

  @override
  dynamic get body => _body;
  @override
  set body(dynamic value) => _body = value;

  @override
  String get type => _type;
  @override
  set type(String value) => _type = value;

  @override
  String toString() {
    return 'Notification(name: $_name, body: $_body, type: $_type)';
  }
}
