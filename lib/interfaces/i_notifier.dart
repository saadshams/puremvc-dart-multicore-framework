//
//  i_notifier.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// The interface definition for a PureMVC [Notifier].
///
/// Classes like [MacroCommand], [SimpleCommand], [Mediator], and [Proxy]
/// use [INotifier] to send [Notification]s without having to construct them manually.
///
/// The [Notifier] base class implements this interface and provides:
/// - A reference to the [IFacade] Multiton instance.
/// - A convenience method for sending notifications.
/// - A simplified API for classes that frequently interact with the [IFacade].
///
/// See also: [IFacade], [INotification]
abstract class INotifier {

  /// Initializes this [INotifier] instance with its Multiton key.
  ///
  /// This method must be called before using [sendNotification] or accessing [facade].
  ///
  /// @param key The Multiton key for this [INotifier].
  void initializeNotifier(String key);

  /// Sends an [INotification].
  ///
  /// This is a convenience method that avoids manual instantiation of
  /// [INotification]s in implementation code.
  ///
  /// @param name The name of the notification.
  /// @param body Optional body of the notification.
  /// @param type Optional type of the notification.
  void sendNotification(String name, [dynamic body, String type]);

}
