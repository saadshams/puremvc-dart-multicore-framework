//
//  facade_test.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import "package:puremvc/puremvc.dart";
import "package:test/test.dart";

void main() {
  /// Test the PureMVC Facade class.
  ///
  /// See also:
  /// - [FacadeTestVO]
  /// - [FacadeTestCommand]
  group("TestFacade", () {

    /// Tests the Facade Multiton Factory Method 
    test("testGetInstance", () {
      // Test Factory Method
      IFacade facade = Facade.getInstance("key", (k) => Facade(k));

      // test assertions
      expect(facade, isNotNull);
      expect(facade, isA<Facade>());
    });

    /// Tests Command registration and execution via the Facade.
    ///
    /// This test gets a Multiton Facade instance
    /// and registers the FacadeTestCommand class
    /// to handle 'FacadeTest' Notifications.
    ///
    /// It then sends a notification using the Facade.
    /// Success is determined by evaluating
    /// a property on an object placed in the body of
    /// the Notification, which will be modified by the Command.
    test("testRegisterCommandAndSendNotification", () {
      // Create the Facade, register the FacadeTestCommand to
      // handle 'FacadeTest' notifications
      IFacade facade = Facade.getInstance("FacadeTestKey2", (k) => Facade(k));
      facade.registerCommand("FacadeTestNote", () => FacadeTestCommand());

      // Send notification. The Command associated with the event
      // (FacadeTestCommand) will be invoked, and will multiply
      // the vo.input value by 2 and set the result on vo.result
      final vo = FacadeTestVO(32);
      facade.sendNotification("FacadeTestNote", vo);

      // test assertions
      expect(vo.result, equals(64), reason: "Expecting vo.result == 64");
    });

    /// Tests Command removal via the Facade.
    ///
    /// This test gets a Multiton Facade instance
    /// and registers the FacadeTestCommand class
    /// to handle 'FacadeTest' Notifications. Then it removes the command.
    ///
    /// It then sends a Notification using the Facade.
    /// Success is determined by evaluating
    /// a property on an object placed in the body of
    /// the Notification, which will NOT be modified by the Command.
    test("testRegisterAndRemoveCommandAndSendNotification", () {
      // Create the Facade, register the FacadeTestCommand to
      // handle 'FacadeTest' events
      IFacade facade = Facade.getInstance("FacadeTestKey3", (k) => Facade(k));
      facade.registerCommand("FacadeTestNote", () => FacadeTestCommand());
      facade.removeCommand("FacadeTestNote");

      // Send notification. The Command associated with the event
      // (FacadeTestCommand) will NOT be invoked, and will NOT multiply
      // the vo.input value by 2
      final vo = FacadeTestVO(32);
      facade.sendNotification("FacadeTestNote", vo);

      // test assertions
      expect(vo.result, isNot(equals(64)), reason: "Expecting vo.result != 64");
    });

    /// Tests registering and retrieving Model proxies via the Facade.
    ///
    /// Tests `registerProxy` and `retrieveProxy` in the same test.
    /// These methods cannot currently be tested separately
    /// in any meaningful way other than to show that the
    /// methods do not throw exceptions when called.
    test("testRegisterAndRetrieveProxy", () {
      // register a proxy and retrieve it.
      IFacade facade = Facade.getInstance("FacadeTestKey4", (k) => Facade(k));
      facade.registerProxy(Proxy("colors", ["red", "green", "blue"]));
      IProxy? proxy = facade.retrieveProxy("colors");

      // test assertions
      expect(proxy, isA<IProxy>(), reason: "Expecting proxy is IProxy");

      // retrieve data from proxy
      final data = proxy?.data as List<String>;

      // test assertions
      expect(data, isNotNull, reason: "Expecting data not null");
      expect(data.length, equals(3), reason: "Expecting data.length == 3");
      expect(data[0], equals("red"), reason: "Expecting data[0] == 'red'");
      expect(data[1], equals("green"), reason: "Expecting data[1] == 'green'");
      expect(data[2], equals("blue"), reason: "Expecting data[2] == 'blue'");
    });

    /// Tests the removing Proxies via the Facade.
    test("testRegisterAndRemoveProxy", () {
      // register a proxy, remove it, then try to retrieve it
      IFacade facade = Facade.getInstance("FacadeTestKey5", (k) => Facade(k));
      IProxy proxy = Proxy("sizes", ["7", "13", "21"]);
      facade.registerProxy(proxy);

      // remove the proxy
      facade.removeProxy("sizes");

      // assert that we removed the appropriate proxy
      expect(proxy.name, equals("sizes"), reason: "Expecting removedProxy.name == 'sizes'");

      // make sure we can no longer retrieve the proxy from the model
      expect(facade.retrieveProxy("sizes"), isNull, reason: "Expecting proxy is null");
    });

    /// Tests registering, retrieving and removing Mediators via the Facade.
    test("testRegisterRetrieveAndRemoveMediator", () {
      // register a mediator, remove it, then try to retrieve it
      IFacade facade = Facade.getInstance("FacadeTestKey6", (k) => Facade(k));
      facade.registerMediator(Mediator(Mediator.NAME, Object()));

      // retrieve the mediator
      expect(facade.retrieveMediator(Mediator.NAME), isNotNull, reason: "Expecting mediator is not null");

      // remove the mediator
      IMediator? removedMediator = facade.removeMediator(Mediator.NAME);

      // assert that we have removed the appropriate mediator
      expect(removedMediator?.name, equals(Mediator.NAME), reason: "Expecting removedMediator.name == Mediator.NAME");

      // assert that the mediator is no longer retrievable
      expect(facade.retrieveMediator(Mediator.NAME), isNull, reason: "Expecting facade.retrieveMediator(Mediator.NAME) == null");
    });

    /// Tests the hasProxy Method
    test("testHasProxy", () {
      // register a Proxy
      IFacade facade = Facade.getInstance("FacadeTestKey7", (k) => Facade(k));
      facade.registerProxy(Proxy("hasProxyTest", [1, 2, 3]));

      // assert that the model.hasProxy method returns true
      // for that proxy name
      expect(facade.hasProxy("hasProxyTest"), isTrue, reason: "Expecting facade.hasProxy('hasProxyTest') == true");
    });

    /// Tests the hasMediator Method
    test("testHasMediator", () {
      // register a Mediator
      IFacade facade = Facade.getInstance("FacadeTestKey8", (k) => Facade(k));
      facade.registerMediator(Mediator("facadeHasMediatorTest", Object()));

      // assert that the facade.hasMediator method returns true
      // for that mediator name
      expect(facade.hasMediator("facadeHasMediatorTest"), isTrue, reason: "Expecting facade.hasMediator('facadeHasMediatorTest') == true");

      facade.removeMediator("facadeHasMediatorTest");

      // assert that the facade.hasMediator method returns false
      // for that mediator name
      expect(facade.hasMediator("facadeHasMediatorTest"), isFalse, reason: "Expecting facade.hasMediator('facadeHasMediatorTest') == false");
    });

    /// Test hasCommand method.
    test("testHasCommand", () {
      // // register the ControllerTestCommand to handle 'hasCommandTest' notes
      IFacade facade = Facade.getInstance("FacadeTestKey10", (k) => Facade(k));
      facade.registerCommand("facadeHasCommandTest", () => FacadeTestCommand());

      // test that hasCommand returns true for hasCommandTest notifications
      expect(facade.hasCommand("facadeHasCommandTest"), isTrue, reason: "Expecting facade.hasCommand('facadeHasCommandTest') == true");

      // Remove the Command from the Controller
      facade.removeCommand("facadeHasCommandTest");

      // test that hasCommand returns false for hasCommandTest notifications
      expect(facade.hasCommand("facadeHasCommandTest"), isFalse, reason: "Expecting facade.hasCommand('facadeHasCommandTest') == false");
    });

    /// Tests the hasCore and removeCore methods
    test("testHasCoreAndRemoveCore", () {
      // assert that the Facade.hasCore method returns false first
      expect(Facade.hasCore("FacadeTestKey11"), isFalse, reason: "Expecting facade.hasCore('FacadeTestKey11') == false");

      // register a Core
      Facade.getInstance("FacadeTestKey11", (k) => Facade(k));

      // assert that the Facade.hasCore method returns true now that a Core is registered
      expect(Facade.hasCore("FacadeTestKey11"), isTrue, reason: "Expecting facade.hasCore('FacadeTestKey11') == true");

      // remove the Core
      Facade.removeCore("FacadeTestKey11");

      // assert that the Facade.hasCore method returns false now that the core has been removed.
      expect(Facade.hasCore("FacadeTestKey11"), isFalse, reason: "Expecting facade.hasCore('FacadeTestKey11') == false");
    });

  });
}

class FacadeTestCommand extends SimpleCommand {
  /// Fabricates a result by multiplying the input by 2.
  ///
  /// [notification] The Notification carrying the FacadeTestVO.
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

  /// Constructor.
  ///
  /// [input] The number to be fed to the FacadeTestCommand.
  FacadeTestVO(this.input);
}