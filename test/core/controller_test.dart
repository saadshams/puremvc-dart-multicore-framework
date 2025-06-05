//
//  controller_test.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import "package:puremvc/puremvc.dart";
import "package:test/test.dart";

void main() {

  /// Tests the PureMVC Controller class.
  ///
  /// See also:
  /// - [ControllerTestVO]
  /// - [ControllerTestCommand]
  group("TestController", () {

    /// Tests the Controller Multiton Factory Method
    test("testGetInstance", () {
      // Get a unique multiton instance of Controller
      IController controller = Controller.getInstance("ControllerTestKey1", (k) => Controller(k));

      // Make sure a Controller instance was returned
      expect(controller, isNotNull);
      expect(controller, isA<Controller>());

      // Call getInstance() again
      IController again = Controller.getInstance("ControllerTestKey1", (k) => Controller(k));

      // Make sure the same instance was returned
      expect(controller, same(again));
    });

    /// Tests command registration and execution.
    ///
    /// This test gets a Multiton `Controller` instance and registers the
    /// `ControllerTestCommand` class to handle `'ControllerTest'` notifications.
    ///
    /// It then constructs such a notification and tells the controller to
    /// execute the associated command. Success is determined by evaluating
    /// a property on an object passed to the command, which will be modified
    /// when the command executes.
    test("testRegisterAndExecuteCommand", () {
      // Create the controller, register the ControllerTestCommand to handle 'ControllerTest' notes
      IController controller = Controller.getInstance("ControllerTestKey2", (k) => Controller(k));
      controller.registerCommand("ControllerTest", () => ControllerTestCommand());

      // Create a 'ControllerTest' note
      final vo = ControllerTestVO(12);
      final note = Notification('ControllerTest', vo);

      // Tell the controller to execute the Command associated with the note
      // the ControllerTestCommand invoked will multiply the vo.input value
      // by 2 and set the result on vo.result
      controller.executeCommand(note);

      // test assertions
      expect(vo.result, equals(24), reason: "Expecting vo.result == 24");
    });

    /// Tests command registration and removal.
    ///
    /// Verifies that once a command is registered and confirmed to be working,
    /// it can be successfully removed from the controller.
    test("testRegisterAndRemoveCommand", () {
      // Create the controller, register the ControllerTestCommand to handle 'ControllerTest' notes
      IController controller = Controller.getInstance("ControllerTestKey3", (k) => Controller(k));
      controller.registerCommand("ControllerRemoveTest", () => ControllerTestCommand());

      // Create a 'ControllerTest' note
      final vo = ControllerTestVO(12);
      var note = Notification('ControllerRemoveTest', vo);

      // Tell the controller to execute the Command associated with the note
      // the ControllerTestCommand invoked will multiply the vo.input value
      // by 2 and set the result on vo.result
      controller.executeCommand(note);

      // test assertions
      expect(vo.result, equals(24), reason: "Expecting vo.result == 24");

      // Reset result
      vo.result = 0;

      // Remove the Command from the Controller
      controller.removeCommand('ControllerRemoveTest');

      // Tell the controller to execute the Command associated with the
      // note. This time, it should not be registered, and our vo result
      // will not change
      controller.executeCommand(note);

      // test assertions
      expect(vo.result, equals(0), reason: "Expecting vo.result == 0");
    });

    /// Test hasCommand method.
    test("testHasCommand", () {
      // register the ControllerTestCommand to handle 'hasCommandTest' notes
      IController controller = Controller.getInstance("ControllerTestKey4", (k) => Controller(k));
      controller.registerCommand("hasTestCommand", () => ControllerTestCommand());

      // test that hasCommand returns true for hasCommandTest notifications
      expect(controller.hasCommand("hasTestCommand"), isTrue, reason: "Expecting controller.hasCommand('hasCommandTest') == true");

      // Remove the Command from the Controller
      controller.removeCommand("hasTestCommand");

      // test that hasCommand returns false for hasCommandTest notifications
      expect(controller.hasCommand("hasTestCommand"), isFalse, reason: "Expecting controller.hasCommand('hasCommandTest') == false");
    });

    /// Tests removing and re-registering a command.
    ///
    /// Verifies that when a command is re-registered, it is not executed twice.
    /// This test registers the command with the controller, but triggers it
    /// via a notification through the view, rather than calling
    /// `executeCommand` directly as done in `testRegisterAndRemove`.
    ///
    /// This test covers a bug that was fixed in AS3 Standard Version 2.0.2.
    /// If run with version 2.0.1, the test will fail.
    test("testReregisterAndExecuteCommand", () {
      // Fetch the controller, register the ControllerTestCommand2 to handle 'ControllerTest2' notes
      IController controller = Controller.getInstance("ControllerTestKey5", (k) => Controller(k));
      controller.registerCommand("ControllerTest2", () => ControllerTestCommand2());

      // Remove the Command from the Controller
      controller.removeCommand("ControllerTest2");

      // Re-register the Command with the Controller
      controller.registerCommand("ControllerTest2", () => ControllerTestCommand2());

      // Create a 'ControllerTest2' note
      final vo = ControllerTestVO(12);
      final note = Notification("ControllerTest2", vo);

      // retrieve a reference to the View from the same core.
      final view = View.getInstance("ControllerTestKey5", (k) => View(k));

      // send the Notification
      view.notifyObservers(note);

      // test assertions
      // if the command is executed once the value will be 24
      expect(vo.result, equals(24), reason: "Expecting vo.result == 24");

      // Prove that accumulation works in the VO by sending the notification again
      view.notifyObservers(note);

      // if the command is executed twice the value will be 48
      expect(vo.result, equals(48), reason: "Expecting vo.result == 48");
    });
  });
}

/// A `SimpleCommand` subclass used by `ControllerTest`.
///
/// See also:
/// - [ControllerTest]
/// - [ControllerTestVO]
class ControllerTestCommand extends SimpleCommand {

  /// Fabricates a result by multiplying the input by 2.
  ///
  /// @param notification The note carrying the `ControllerTestVO`.
  @override
  execute(INotification notification) {
    var vo = notification.body as ControllerTestVO;

    // Fabricate a result
    vo.result = 2 * vo.input;
  }
}

/// A `SimpleCommand` subclass used by `ControllerTest`.
///
/// @see ControllerTest
/// @see ControllerTestVO
class ControllerTestCommand2 extends SimpleCommand {
  /// Fabricates a result by multiplying the input by 2 and adding it to the existing result.
  ///
  /// This tests the accumulation effect that would appear if the command
  /// were executed more than once.
  ///
  /// @param notification The note carrying the `ControllerTestVO`.
  @override
  execute(INotification notification) {
    var vo = notification.body as ControllerTestVO;

    // Fabricate a result
    vo.result = vo.result+(2 * vo.input);
  }
}

/// A utility class used by `ControllerTest`.
///
/// @see ControllerTest
/// @see ControllerTestCommand
class ControllerTestVO {
  int input = 0;
  int result = 0;

  /// Constructor.
  ///
  /// @param input The number to be fed to the `ControllerTestCommand`.
  ControllerTestVO(this.input);
}