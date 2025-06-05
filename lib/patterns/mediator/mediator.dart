//
//  mediator.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// A base [IMediator] implementation.
///
/// In PureMVC, [IMediator] implementors assume these responsibilities:
///
/// - Implement a method that returns a list of all [INotification] names the [IMediator] is interested in.
/// - Implement a notification (callback) method for handling [INotification]s.
/// - Implement methods called when the [IMediator] is registered or removed from an [IView].
///
/// Additionally, [IMediator]s typically:
///
/// - Act as intermediaries between one or more view components and the rest of the application.
/// - Place [Event] listeners on view components and implement handlers which often send [INotification]s or interact with [IProxy]s to post or retrieve data.
/// - Receive [INotification]s (typically containing data) and update view components accordingly.
///
/// When an [IMediator] is registered with the [IView], its [listNotificationInterests] method is called.
/// The [IMediator] returns a [List] of [INotification] names it wishes to be notified about.
///
/// The [IView] then creates an [IObserver] object encapsulating the [IMediator] and its [handleNotification] method,
/// registering the [IObserver] for each [INotification] name returned.
///
/// See [INotification], [IView].
class Mediator extends Notifier implements IMediator {

  static const NAME = "Mediator";

  final String _name;

  dynamic _view;

  /// Constructor.
  ///
  /// @param [name] the name this [IMediator] will be registered with.
  /// @param [view] the View Component (optional).
  Mediator([String? name, this._view]) : _name = name ?? NAME;

  /// Called by the [IView] when the [IMediator] is registered.
  @override
  void onRegister() {}

  /// Called by the [IView] when the [IMediator] is removed.
  @override
  void onRemove() {}

  /// List [INotification] interests.
  ///
  /// @returns [List<String>] a list of the [INotification] names this [IMediator] is interested in.
  @override
  List<String> listNotificationInterests() {
    return [];
  }

  /// Handle an [INotification].
  ///
  /// @param [notification] the [INotification] to be handled.
  @override
  void handleNotification(INotification notification) {

  }

  /// This [IMediator]'s [name].
  @override
  String get name => _name;

  /// This [IMediator]'s [view].
  @override
  dynamic get view => _view;
  @override
  set view(dynamic value) => _view = value;

}
