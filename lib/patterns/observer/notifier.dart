//
//  notifier.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// A base [INotifier] implementation.
///
/// [MacroCommand], [SimpleCommand], [Mediator], and [Proxy]
/// need to send [Notifications].
///
/// The [INotifier] interface provides a common method, [sendNotification],
/// which simplifies creating and sending [INotification]s.
///
/// The [Notifier] class, extended by these classes,
/// holds an initialized reference to an [IFacade] Multiton,
/// easing access to the facade and notification sending.
///
/// NOTE: In MultiCore, [Notifier]s require a valid multitonKey
/// before sending notifications or accessing the facade.
///
/// The multitonKey is set:
///   * on a [ICommand] when created by the [Controller]
///   * on a [IMediator] when registered with the [IView]
///   * on a [IProxy] when registered with the [IModel]
///
/// See [Proxy], [Facade], [Mediator], [MacroCommand], [SimpleCommand].
class Notifier implements INotifier {

  late String _multitonKey;

  /// Initialize this [INotifier] instance.
  ///
  /// Sets the [multitonKey]. Calls to [sendNotification] or access to [facade]
  /// will fail until this is called.
  ///
  /// - Param [key] - the Multiton key for this [INotifier].
  @override
  void initializeNotifier(String key) {
    _multitonKey = key;
  }

  /// Send an [INotification].
  ///
  /// Convenience method to avoid manually constructing [INotification] instances.
  ///
  /// - Param [name] - the name of the notification to send.
  /// - Param [body] - optional body of the notification.
  /// - Param [type] - optional type of the notification.
  @override
  void sendNotification(String name, [body, String type = ""]) {
    facade.sendNotification(name, body, type);
  }

  /**
   *  Return the Multiton Facade instance
   *  -  Throws [MultitonErrorNotifierLacksKey] if no multitonKey is set. Usually means facade getter is being accessed before initializeNotifier has been called (i.e., from the constructor). Defer facade access until the onRegister method.
   */
  IFacade get facade {
    return Facade.getInstance(_multitonKey, (k) => Facade(k));
  }

  /// The Multiton Key for this app
  String get multitonKey => _multitonKey;
  set multitonKey(String value) => _multitonKey = value;
}
