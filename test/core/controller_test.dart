import "package:puremvc/puremvc.dart";
import "package:test/test.dart";

void main() {
  group("TestController", () {
    test("testGetInstance", () {
      final controller = Controller.getInstance("ControllerTestKey1", (k) => Controller(k));
      expect(controller, isNotNull);
      expect(controller, isA<Controller>());
    });

    test("testRegisterAndExecuteCommand", () {
      final controller = Controller.getInstance("ControllerTestKey2", (k) => Controller(k));
      controller.registerCommand("ControllerTest", () => ControllerTestCommand());
      final vo = ControllerTestVO(12);
      final note = Notification('ControllerTest', vo);

      controller.executeCommand(note);
      expect(vo.result, equals(24), reason: "Expecting vo.result == 24");
    });

    test("testRegisterAndRemoveCommand", () {
      final controller = Controller.getInstance("ControllerTestKey3", (k) => Controller(k));
      controller.registerCommand("ControllerRemoveTest", () => ControllerTestCommand());

      final vo = ControllerTestVO(12);
      var note = Notification('ControllerRemoveTest', vo);

      controller.executeCommand(note);

      expect(vo.result, equals(24), reason: "Expecting vo.result == 24");

      vo.result = 0;
      controller.removeCommand('ControllerRemoveTest');
      controller.executeCommand(note);

      expect(vo.result, equals(0), reason: "Expecting vo.result == 0");
    });

    test("testHasCommand", () {
      final controller = Controller.getInstance("ControllerTestKey4", (k) => Controller(k));
      controller.registerCommand("hasTestCommand", () => ControllerTestCommand());

      expect(controller.hasCommand("hasTestCommand"), isTrue, reason: "Expecting controller.hasCommand('hasCommandTest') == true");

      controller.removeCommand("hasTestCommand");

      expect(controller.hasCommand("hasTestCommand"), isFalse, reason: "Expecting controller.hasCommand('hasCommandTest') == false");
    });

    test("testReregisterAndExecuteCommand", () {
      final controller = Controller.getInstance("ControllerTestKey5", (k) => Controller(k));
      controller.registerCommand("ControllerTest2", () => ControllerTestCommand2());
      controller.removeCommand("ControllerTest2");

      controller.registerCommand("ControllerTest2", () => ControllerTestCommand2());
      
      final vo = ControllerTestVO(12);
      final note = Notification("ControllerTest2", vo);
      
      final view = View.getInstance("ControllerTestKey5", (k) => View(k));

      view.notifyObservers(note);

      expect(vo.result, equals(24), reason: "Expecting vo.result == 24");

      view.notifyObservers(note);

      expect(vo.result, equals(48), reason: "Expecting vo.result == 48");
    });
  });
}

class ControllerTestCommand extends SimpleCommand {
  @override
  execute(INotification notification) {
    var vo = notification.body as ControllerTestVO;

    // Fabricate a result
    vo.result = 2 * vo.input;
  }
}

class ControllerTestCommand2 extends SimpleCommand {
  @override
  execute(INotification notification) {
    var vo = notification.body as ControllerTestVO;

    // Fabricate a result
    vo.result = vo.result+(2 * vo.input);
  }
}

class ControllerTestVO {
  int input = 0;
  int result = 0;

  ControllerTestVO(this.input);
}