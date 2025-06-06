//
//  macro_command_test.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import "package:puremvc/puremvc.dart";
import "package:test/test.dart";

void main() {

  /// Test the PureMVC `SimpleCommand` class.
  ///
  /// See also:
  /// - [MacroCommandTestVO]
  /// - [MacroCommandTestCommand]
  group("TestMacroCommand", () {

    /// Tests operation of a `MacroCommand`.
    ///
    /// This test creates a `Notification` with a `MacroCommandTestVO` as the body.
    /// Then it creates a `MacroCommandTestCommand` and calls its `execute` method,
    /// passing in the `Notification`.
    ///
    /// The `MacroCommandTestCommand` defines an `initializeMacroCommand` method
    /// that adds two subcommands: `MacroCommandTestSub1Command` and
    /// `MacroCommandTestSub2Command`.
    ///
    /// The `MacroCommandTestVO` has two result properties:
    /// - One is set by `MacroCommandTestSub1Command`, multiplying the input by 2.
    /// - The other is set by `MacroCommandTestSub2Command`, multiplying the input by itself.
    ///
    /// Success is determined by evaluating the two result properties on the
    /// `MacroCommandTestVO` passed in the `Notification` body.
    test("testMacroCommandExecute", () {
      // Create the VO
      final vo = MacroCommandTestVO(5);

      // Create the Notification (note)
      final note = Notification("MacroCommandTest", vo);
      final command = MacroCommandTestCommand();

      // Create the SimpleCommand
      command.initializeNotifier("NotifierKey1");

      // Execute the SimpleCommand
      command.execute(note);

      // test assertions
      expect(vo.result1, equals(10));
      expect(vo.result2, equals(25));
    });

  });
}

/// A `MacroCommand` subclass used by `MacroCommandTest`.
///
/// See also:
/// - [MacroCommandTest]
/// - [MacroCommandTestSub1Command]
/// - [MacroCommandTestSub2Command]
/// - [MacroCommandTestVO]
class MacroCommandTestCommand extends MacroCommand {

  /// Initializes the `MacroCommandTestCommand` by adding its two subcommands.
  @override
  initializeMacroCommand() {
    addSubCommand(() => MacroCommandTestSub1Command());
    addSubCommand(() => MacroCommandTestSub2Command());
  }
}

/// A `SimpleCommand` subclass used by `MacroCommandTestCommand`.
///
/// See also:
/// - [MacroCommandTest]
/// - [MacroCommandTestCommand]
/// - [MacroCommandTestVO]
class MacroCommandTestSub1Command extends SimpleCommand {

  /// Computes a result by multiplying the input by 2.
  ///
  /// @param event The event carrying the `MacroCommandTestVO`.
  @override
  execute(INotification notification) {
    final vo = notification.body as MacroCommandTestVO;

    // Fabricate a result
    vo.result1 = 2 * vo.input;
  }
}

/// A `SimpleCommand` subclass used by `MacroCommandTestCommand`.
///
/// See also:
/// - [MacroCommandTest]
/// - [MacroCommandTestCommand]
/// - [MacroCommandTestVO]
class MacroCommandTestSub2Command extends SimpleCommand {

  /// Computes a result by multiplying the input by itself.
  ///
  /// The [event] carries the `MacroCommandTestVO`.
  @override
  execute(INotification notification) {
    final vo = notification.body as MacroCommandTestVO;

    // Fabricate a result
    vo.result2 = vo.input * vo.input;
  }
}

class MacroCommandTestVO {
  int input;
  int result1 = 0;
  int result2 = 0;

  /// Creates a new instance.
  ///
  /// The [input] is the number to be passed to the `MacroCommandTestCommand`.
  MacroCommandTestVO(this.input);
}