//
//  model_test.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import "package:puremvc/puremvc.dart";
import "package:test/test.dart";

void main() {

  /// Test the PureMVC Model class.
  group("TestModel", () {

    /// Tests the Model Multiton Factory Method
    test("testGetInstance", () {
      // Test Factory Method
      IModel model = Model.getInstance("ModelTestKey1", (k) => Model(k));

      // test assertions
      expect(model, isNotNull);
      expect(model, isA<Model>());

      // Call getInstance() again
      IModel again = Model.getInstance("ModelTestKey1", (k) => Model(k));

      // Make sure the same instance was returned
      expect(model, same(again));
    });

    /// Tests the proxy registration and retrieval methods.
    ///
    /// Tests `registerProxy` and `retrieveProxy` together,
    /// since they cannot currently be tested separately in any meaningful way.
    /// This primarily verifies that the methods do not throw exceptions when called.
    test("testRegisterAndRetrieveProxy", () {
      // register a proxy and retrieve it.
      IModel model = Model.getInstance("ModelTestKey2", (k) => Model(k));
      model.registerProxy(Proxy("colors", ["red", "green", "blue"]));

      IProxy proxy = model.retrieveProxy("colors")!;
      final data = proxy.data as List<String>;

      // test assertions
      expect(data, isNotNull, reason: "Expecting data not null");
      expect(data.length, equals(3), reason: "Expecting data.length == 3");
      expect(data[0], equals("red"), reason: "Expecting data[0] == 'red'");
      expect(data[1], equals("green"), reason: "Expecting data[1] == 'green'");
      expect(data[2], equals("blue"), reason: "Expecting data[2] == 'blue'");
    });

    /// Tests the proxy removal method.
    test("testRegisterAndRemoveProxy", (){
      // register a proxy, remove it, then try to retrieve it
      IModel model = Model.getInstance("ModelTestKey3", (k) => Model(k));
      IProxy proxy = Proxy("sizes", ["7", "13", "21"]);
      model.registerProxy(proxy);

      // remove the proxy
      final removedProxy = model.removeProxy("sizes")!;

      // assert that we removed the appropriate proxy
      expect(removedProxy.name, equals("sizes"), reason: "Expecting removedProxy.getProxyName() == 'sizes'");

      // ensure that the proxy is no longer retrievable from the model
      expect(model.retrieveProxy("sizes"), isNull, reason: "Expecting proxy is null");

      // test assertions
      expect(model.retrieveProxy("sizes"), isNull, reason: "Expecting proxy is null");
    });

    /// Tests the hasProxy Method
    test("Expecting proxy is null", () {
      // register a proxy
      IModel model = Model.getInstance("ModelTestKey4", (k) => Model(k));
      IProxy proxy = Proxy("aces", ["clubs", "spades", "hearts", "diamonds"]);
      model.registerProxy(proxy);

      // assert that the model.hasProxy method returns true
      // for that proxy name
      expect(model.hasProxy("aces"), isTrue, reason: "Expecting model.hasProxy('aces') == true");

      // remove the proxy
      model.removeProxy("aces");

      // assert that the model.hasProxy method returns false
      // for that proxy name
      expect(model.hasProxy("aces"), isFalse, reason: "Expecting model.hasProxy('aces') == false");
    });

    /// Tests that the Model calls the onRegister and onRemove methods
    test("testOnRegisterAndOnRemove", () {
      // Get a Multiton View instance
      IModel model = Model.getInstance("ModelTestKey5", (k) => Model(k));

      // Create and register the test mediator
      IProxy proxy = ModelTestProxy();
      model.registerProxy(proxy);

      // assert that onRegsiter was called, and the proxy responded by setting its data accordingly
      expect(proxy.data, equals(ModelTestProxy.onRegisterCalled), reason: "Expecting proxy.data == ModelTestProxy.ON_REGISTER_CALLED");

      // Remove the component
      model.removeProxy(ModelTestProxy.NAME);

      // assert that onRemove was called, and the proxy responded by setting its data accordingly
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
