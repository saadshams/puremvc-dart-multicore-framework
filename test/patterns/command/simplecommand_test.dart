import "package:puremvc/puremvc.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("TestSimpleCommand", () {

    test("testSimpleCommandExecute", () {
      final vo = SimpleCommandTestVO(5);
      final note = Notification("SimpleCommandTestNote", vo);
      final command = SimpleCommandTestCommand();
      command.execute(note);

      expect(vo.result, equals(10));
    });

  });
}

class SimpleCommandTestCommand extends SimpleCommand {
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

  SimpleCommandTestVO(this.input);
}