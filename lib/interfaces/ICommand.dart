//
//  ICommand.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// The interface definition for a PureMVC MultiCore Command.
///
/// See [IController], [INotification]
abstract class ICommand extends INotifier {

  /// Executes the [ICommand]'s logic to handle a given [INotification].
  ///
  /// @param notification An [INotification] to handle.
  void execute(INotification notification);

}
