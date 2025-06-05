//
//  I_controller.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// The interface definition for a PureMVC MultiCore Controller.
///
/// In PureMVC, an [IController] implementor follows the 'Command and Controller'
/// strategy, and assumes these responsibilities:
///
/// - Remembering which [ICommand]s are intended to handle which [INotification]s.
/// - Registering itself as an [IObserver] with the [IView] for each [INotification]
///   that it has an [ICommand] mapping for.
/// - Creating a new instance of the proper [ICommand] to handle a given [INotification]
///   when notified by the [IView].
/// - Calling the [ICommand]'s [execute] method, passing in the [INotification].
///
/// See [INotification], [ICommand]
abstract class IController {

  /// Register an [INotification] to [ICommand] mapping with the [IController].
  ///
  /// @param notificationName The name of the [INotification] to associate with the [ICommand].
  /// @param factory A function that creates a new instance of the [ICommand].
  void registerCommand(String notificationName, ICommand Function() factory);

  /// Execute the [ICommand] previously registered as the handler for the given [INotification].
  ///
  /// @param notification The [INotification] to execute the associated [ICommand] for.
  void executeCommand(INotification notification);


  /// Check if an [ICommand] is registered for a given [INotification] name.
  ///
  /// @param notificationName The name of the [INotification].
  /// @returns Whether an [ICommand] is currently registered for the given [noteName].
  bool hasCommand(String notificationName);

  /// Remove a previously registered [INotification] to [ICommand] mapping.
  ///
  /// @param notificationName The name of the [INotification] to remove the [ICommand] mapping for.
  void removeCommand(String notificationName);

}
