//
//  SimpleCommand.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// A base [ICommand] implementation for executing a block of business logic.
///
/// Subclasses should override the [execute] method to implement
/// the business logic that handles the given [INotification].
///
/// See [ICommand], [IController], [INotification], [MacroCommand], [INotifier].
class SimpleCommand extends Notifier implements ICommand {

  /// Respond to the [INotification] that triggered this [SimpleCommand].
  ///
  /// Perform business logic such as complex validation, processing, or model changes.
  ///
  /// @param notification The [INotification] object that triggered the execution of this [SimpleCommand].
  @override
  void execute(INotification notification) {

  }

}
