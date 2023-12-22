import "package:puremvc/puremvc.dart";
import "package:test/test.dart";

void main() {
  group("TestFacade", () {

    test("testGetInstance", () {
      final facade = Facade.getInstance("key", (k) => Facade(k));
      expect(facade, isNotNull);
      expect(facade, isA<Facade>());
    });

    test("testRegisterCommandAndSendNotification", () {
      final facade = Facade.getInstance("FacadeTestKey2", (k) => Facade(k));
      facade.registerCommand("FacadeTestNote", () => FacadeTestCommand());
      final vo = FacadeTestVO(32);
      facade.sendNotification("FacadeTestNote", vo);
      expect(vo.result, equals(64), reason: "Expecting vo.result == 64");
    });

    test("testRegisterAndRemoveCommandAndSendNotification", () {
      final facade = Facade.getInstance("FacadeTestKey3", (k) => Facade(k));
      facade.registerCommand("FacadeTestNote", () => FacadeTestCommand());
      facade.removeCommand("FacadeTestNote");

      final vo = FacadeTestVO(32);
      facade.sendNotification("FacadeTestNote", vo);
      expect(vo.result, isNot(equals(64)), reason: "Expecting vo.result != 64");
    });

    test("testRegisterAndRetrieveProxy", () {
      final facade = Facade.getInstance("FacadeTestKey4", (k) => Facade(k));
      facade.registerProxy(Proxy("colors", ["red", "green", "blue"]));
      final proxy = facade.retrieveProxy("colors")!;
      expect(proxy, isA<IProxy>(), reason: "Expecting proxy is IProxy");

      final data = proxy.data as List<String>;

      expect(data, isNotNull, reason: "Expecting data not null");
      expect(data.length, equals(3), reason: "Expecting data.length == 3");
      expect(data[0], equals("red"), reason: "Expecting data[0] == 'red'");
      expect(data[1], equals("green"), reason: "Expecting data[1] == 'green'");
      expect(data[2], equals("blue"), reason: "Expecting data[2] == 'blue'");
    });

    test("testRegisterAndRemoveProxy", () {
      final facade = Facade.getInstance("FacadeTestKey5", (k) => Facade(k));
      final proxy = Proxy("sizes", ["7", "13", "21"]);
      facade.registerProxy(proxy);

      facade.removeProxy("sizes")!;
      expect(proxy.proxyName, equals("sizes"), reason: "Expecting removedProxy.name == 'sizes'");
      expect(facade.retrieveProxy("sizes"), isNull, reason: "Expecting proxy is null");
    });

    test("testRegisterRetrieveAndRemoveMediator", () {
      final facade = Facade.getInstance("FacadeTestKey6", (k) => Facade(k));
      facade.registerMediator(Mediator(Mediator.NAME, Object()));
      expect(facade.retrieveMediator(Mediator.NAME), isNotNull, reason: "Expecting mediator is not null");

      final removedMediator = facade.removeMediator(Mediator.NAME)!;
      expect(removedMediator.mediatorName, equals(Mediator.NAME), reason: "Expecting removedMediator.name == Mediator.NAME");

      expect(facade.retrieveMediator(Mediator.NAME), isNull, reason: "Expecting facade.retrieveMediator(Mediator.NAME) == null");
    });

    test("testHasProxy", () {
      final facade = Facade.getInstance("FacadeTestKey7", (k) => Facade(k));
      facade.registerProxy(Proxy("hasProxyTest", [1, 2, 3]));
      expect(facade.hasProxy("hasProxyTest"), isTrue, reason: "Expecting facade.hasProxy('hasProxyTest') == true");
    });

    test("testHasMediator", () {
      final facade = Facade.getInstance("FacadeTestKey8", (k) => Facade(k));
      facade.registerMediator(Mediator("facadeHasMediatorTest", Object()));
      expect(facade.hasMediator("facadeHasMediatorTest"), isTrue, reason: "Expecting facade.hasMediator('facadeHasMediatorTest') == true");

      facade.removeMediator("facadeHasMediatorTest");

      expect(facade.hasMediator("facadeHasMediatorTest"), isFalse, reason: "Expecting facade.hasMediator('facadeHasMediatorTest') == false");
    });

    test("testHasCommand", () {
      final facade = Facade.getInstance("FacadeTestKey10", (k) => Facade(k));
      facade.registerCommand("facadeHasCommandTest", () => FacadeTestCommand());
      expect(facade.hasCommand("facadeHasCommandTest"), isTrue, reason: "Expecting facade.hasCommand('facadeHasCommandTest') == true");

      facade.removeCommand("facadeHasCommandTest");
      expect(facade.hasCommand("facadeHasCommandTest"), isFalse, reason: "Expecting facade.hasCommand('facadeHasCommandTest') == false");
    });

    test("testHasCoreAndRemoveCore", () {
      expect(Facade.hasCore("FacadeTestKey11"), isFalse, reason: "Expecting facade.hasCore('FacadeTestKey11') == false");

      Facade.getInstance("FacadeTestKey11", (k) => Facade(k));
      
      expect(Facade.hasCore("FacadeTestKey11"), isTrue, reason: "Expecting facade.hasCore('FacadeTestKey11') == true");

      Facade.removeCore("FacadeTestKey11");

      expect(Facade.hasCore("FacadeTestKey11"), isFalse, reason: "Expecting facade.hasCore('FacadeTestKey11') == false");
    });

  });
}

class FacadeTestCommand extends SimpleCommand {
  @override
  void execute(INotification notification) {
    var vo = notification.body as FacadeTestVO;

    // Fabricate a result
    vo.result = 2 * vo.input;
  }
}

class FacadeTestVO {
  int input = 0;
  int result = 0;

  FacadeTestVO(this.input);
}