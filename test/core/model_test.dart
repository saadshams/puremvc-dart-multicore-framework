import "package:puremvc/puremvc.dart";
import "package:test/test.dart";

void main() {
  group("TestModel", () {

    test("testGetInstance", () {
      final model = Model.getInstance("ModelTestKey1", (k) => Model(k));
      expect(model, isNotNull);
      expect(model, isA<Model>());
    });

    test("testRegisterAndRetrieveProxy", () {
      final model = Model.getInstance("ModelTestKey2", (k) => Model(k));
      model.registerProxy(Proxy("colors", ["red", "green", "blue"]));

      final proxy = model.retrieveProxy("colors")!;
      final data = proxy.data as List<String>;
      expect(data, isNotNull, reason: "Expecting data not null");
      expect(data.length, equals(3), reason: "Expecting data.length == 3");
      expect(data[0], equals("red"), reason: "Expecting data[0] == 'red'");
      expect(data[1], equals("green"), reason: "Expecting data[1] == 'green'");
      expect(data[2], equals("blue"), reason: "Expecting data[2] == 'blue'");
    });

    test("testRegisterAndRemoveProxy", (){
      final model = Model.getInstance("ModelTestKey3", (k) => Model(k));
      final proxy = Proxy("sizes", ["7", "13", "21"]);
      model.registerProxy(proxy);

      final removedProxy = model.removeProxy("sizes")!;

      expect(removedProxy.proxyName, equals("sizes"), reason: "Expecting removedProxy.getProxyName() == 'sizes'");

      expect(model.retrieveProxy("sizes"), isNull, reason: "Expecting proxy is null");
    });

    test("Expecting proxy is null", () {
      final model = Model.getInstance("ModelTestKey4", (k) => Model(k));
      final proxy = Proxy("aces", ["clubs", "spades", "hearts", "diamonds"]);
      model.registerProxy(proxy);

      expect(model.hasProxy("aces"), isTrue, reason: "Expecting model.hasProxy('aces') == true");

      model.removeProxy("aces");

      expect(model.hasProxy("aces"), isFalse, reason: "Expecting model.hasProxy('aces') == false");
    });

    test("testOnRegisterAndOnRemove", () {
      final model = Model.getInstance("ModelTestKey5", (k) => Model(k));
      final proxy = ModelTestProxy();

      model.registerProxy(proxy);

      expect(proxy.data, equals(ModelTestProxy.onRegisterCalled), reason: "Expecting proxy.data == ModelTestProxy.ON_REGISTER_CALLED");

      model.removeProxy(ModelTestProxy.NAME);
      expect(proxy.data, equals(ModelTestProxy.onRemoveCalled), reason: "Expecting proxy.data == ModelTestProxy.ON_REMOVE_CALLED");
    });

  });
}

class ModelTestProxy extends Proxy {
  static String NAME = "ModelTestProxy";
  static String onRegisterCalled = "onRegister Called";
  static String onRemoveCalled = "onRemove Called";

  ModelTestProxy(): super(ModelTestProxy.NAME, "");

  @override
  void onRegister() {
    data = onRegisterCalled;
  }

  @override
  void onRemove() {
    data = onRemoveCalled;
  }
}
