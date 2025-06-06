//
//  proxy_test.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import "package:puremvc/puremvc.dart";
import "package:test/test.dart";

void main() {
  /// Test the PureMVC Proxy class.
  ///
  /// See also:
  /// - [IProxy]
  /// - [Proxy]
  group("TestProxy", () {

    /// Tests getting the default name using Mediator class accessor method.
    test("testDefaultNameAccessor", () {
      IProxy proxy = Proxy();
      expect(proxy.name, equals(Proxy.NAME));
    });

    /// Tests getting the name using Proxy class accessor method. Setting can only be done in constructor.
    test("testNameAccessor", () {
      // Create a new Proxy and use accessors to set the proxy name
      IProxy proxy = Proxy("TestProxy");

      // test assertions
      expect(proxy.name, equals("TestProxy"));
    });

    /// Tests setting and getting the data using Proxy class accessor methods.
    test("testDataAccessors", () {
      // Create a new Proxy and use accessors to set the data
      IProxy proxy = Proxy("colors");
      proxy.data = ["red", "green", "blue"];

      // test assertions
      List<String> data = proxy.data;
      expect(proxy.data, same(data));
    });

    /// Tests setting the name and body using the Notification class Constructor.
    test("testConstructor", () {
      // Create a new Proxy using the Constructor to set the name and data
      IProxy proxy = Proxy("colors", ["red", "green", "blue"]);
      expect(proxy.name, equals("colors"));
      List<String> data = proxy.data;

      // test assertions
      expect(data.length, equals(3), reason: "Expecting data.length == 3");
      expect(data[0], equals("red"), reason: "Expecting data[0] == 'red'");
      expect(data[1], equals("green"), reason: "Expecting data[1] == 'green'");
      expect(data[2], equals("blue"), reason: "Expecting data[2] == 'blue'");
    });

  });
}
