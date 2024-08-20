import "package:puremvc/puremvc.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("TestMacroCommand", () {

    test("testMacroCommandExecute", () {
      final vo = MacroCommandTestVO(5);
      final note = Notification("MacroCommandTest", vo);
      final command = MacroCommandTestCommand();
      command.initializeNotifier("NotifierKey1");
      command.execute(note);

      expect(vo.result1, equals(10));
      expect(vo.result2, equals(25));
    });

  });
}

class MacroCommandTestCommand extends MacroCommand {
  @override
  initializeMacroCommand() {
    addSubCommand(() => MacroCommandTestSub1Command());
    addSubCommand(() => MacroCommandTestSub2Command());
  }
}

class MacroCommandTestSub1Command extends SimpleCommand {
  @override
  execute(INotification notification) {
    final vo = notification.body as MacroCommandTestVO;

    // Fabricate a result
    vo.result1 = 2 * vo.input;
  }
}

class MacroCommandTestSub2Command extends SimpleCommand {
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

  MacroCommandTestVO(this.input);
}