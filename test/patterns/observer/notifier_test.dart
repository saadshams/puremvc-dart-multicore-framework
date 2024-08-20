import "package:puremvc/puremvc.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {

  group("TestNotifier", () {

    test("testRegisterCommandAndSendNotification", () {
      final notifier = Notifier();
      notifier.initializeNotifier("NotifierTestKey1");
      notifier.facade.registerCommand("NotifierTestNote", () => NotifierTestCommand());

      final vo = NotifierTestVO(32);
      notifier.sendNotification("NotifierTestNote", vo);
      expect(vo.result, equals(64), reason: "Expecting vo.result == 64");
    });

  });
}

class NotifierTestCommand extends SimpleCommand {
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

  NotifierTestVO(this.input);
}
