//
//  simple_command_test.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import "package:puremvc/puremvc.dart";
import "package:test/test.dart";

void main() {
  /// Tests the PureMVC SimpleCommand class.
  ///
  /// See also:
  /// - [SimpleCommandTestVO]
  /// - [SimpleCommandTestCommand]
  group("TestSimpleCommand", () {

    /// Tests the `execute` method of a `SimpleCommand`.
    ///
    /// This test creates a new `Notification` with a `SimpleCommandTestVO` as its body.
    /// It then creates a `SimpleCommandTestCommand` and calls its `execute` method with the notification.
    ///
    /// Success is determined by checking a property on the object passed in the notification body,
    /// which should be modified by the `SimpleCommand`.
    test("testSimpleCommandExecute", () {
      // Create the VO
      final vo = SimpleCommandTestVO(5);

      // Create the Notification (note)
      final note = Notification("SimpleCommandTestNote", vo);

      // Create the SimpleCommand
      final command = SimpleCommandTestCommand();

      // Execute the SimpleCommand
      command.execute(note);

      // test assertions
      expect(vo.result, equals(10));
    });

  });
}

/// A `SimpleCommand` subclass used by `SimpleCommandTest`.
///
/// See also:
/// - `SimpleCommandTest`
/// - `SimpleCommandTestVO`
class SimpleCommandTestCommand extends SimpleCommand {

  /// Fabricates a result by multiplying the input by 2.
  ///
  /// @param event The `INotification` carrying the `SimpleCommandTestVO`.
  @override
  execute(INotification notification) {
    var vo = notification.body as SimpleCommandTestVO;

    // Fabricate a result
    vo.result = 2 * vo.input;
  }
}

class SimpleCommandTestVO {
  int input;
  int result = 0;

  /// Constructor.
  ///
  /// @param input The number to be fed to the SimpleCommandTestCommand.
  SimpleCommandTestVO(this.input);
}