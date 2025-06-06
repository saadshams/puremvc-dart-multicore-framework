//
//  notifier_test.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import "package:puremvc/puremvc.dart";
import "package:test/test.dart";

void main() {

  /// Test the PureMVC Notifier class.
  ///
  /// See also:
  /// - [NotifierTestVO]
  /// - [NotifierTestCommand]
  group("TestNotifier", () {

    /// Tests Command registration and execution via the Facade.
    test("testRegisterCommandAndSendNotification", () {
      // Create the Notifier, register the FacadeTestCommand to
      // handle 'NotifierTestNote' notifications
      final notifier = Notifier();
      notifier.initializeNotifier("NotifierTestKey1");
      notifier.facade.registerCommand("NotifierTestNote", () => NotifierTestCommand());

      // Send notification. The Command associated with the event
      // (NotifierTestCommand) will be invoked, and will multiply
      // the vo.input value by 2 and set the result on vo.result
      final vo = NotifierTestVO(32);
      notifier.sendNotification("NotifierTestNote", vo);

      // test assertions
      expect(vo.result, equals(64), reason: "Expecting vo.result == 64");
    });

  });
}

class NotifierTestCommand extends SimpleCommand {
  /// Fabricates a result by multiplying the input by 2.
  ///
  /// [notification] The Notification carrying the NotifierTestVO.
  @override
  void execute(INotification notification) {
    var vo = notification.body as NotifierTestVO;

    // Fabricate a result
    vo.result = 2 * vo.input;
  }
}

class NotifierTestVO {
  int input = 0;
  int result = 0;

  /// Constructor.
  ///
  /// [input] The number to be fed to the NotifierTestCommand.
  NotifierTestVO(this.input);
}
