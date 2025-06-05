//
//  macro_command.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// A base [ICommand] implementation that synchronously executes other [ICommand]s.
///
/// An [MacroCommand] maintains a list of [ICommand] factories called 'SubCommands'.
///
/// When [execute] is called, the [MacroCommand] instantiates and calls [execute]
/// on each of its 'SubCommands' in turn. Each 'SubCommand' receives a reference
/// to the original [INotification].
///
/// Unlike [SimpleCommand], subclasses should not override [execute], but instead
/// override [initializeMacroCommand], calling [addSubCommand] once for each
/// 'SubCommand' to be executed.
///
/// See [ICommand], [IController], [INotification], [SimpleCommand], [INotifier].
class MacroCommand extends Notifier implements ICommand {

  /// This [MacroCommand]'s 'SubCommands'
  List<ICommand Function()> subCommands = [];

  /// Constructor.
  ///
  /// Subclasses should not need to define a constructor.
  /// Instead, override the [initializeMacroCommand] method.
  MacroCommand() {
    initializeMacroCommand();
  }

  /// Initialize the [MacroCommand].
  ///
  /// Override this method in your subclass to initialize the [MacroCommand]'s 'SubCommand' list
  /// by calling [addSubCommand] with [ICommand] factories.
  ///
  /// Note that 'SubCommand's may be any [ICommand] implementor; both [MacroCommand]s and [SimpleCommand]s are acceptable.
  void initializeMacroCommand() {

  }

  /// Add a 'SubCommand'.
  ///
  /// The 'SubCommand' will be executed in First In/First Out (FIFO) order.
  ///
  /// @param factory A function that constructs an instance of an [ICommand].
  void addSubCommand(ICommand Function() factory) {
    subCommands.add(factory);
  }

  /// Execute this [MacroCommand]'s 'SubCommands'.
  ///
  /// The 'SubCommands' will be executed in First In/First Out (FIFO) order.
  ///
  /// @param notification The [INotification] object to pass to each 'SubCommand'.
  @override
  void execute(INotification notification) {
    while (subCommands.isNotEmpty) {
      final factory = subCommands.removeAt(0);
      ICommand command = factory();
      command.initializeNotifier(multitonKey);
      command.execute(notification);
    }
  }

}
