import "package:puremvc/puremvc.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("TestProxy", () {

    test("testDefaultNameAccessor", () {
      final proxy = Proxy();
      expect(proxy.proxyName, equals(Proxy.NAME));
    });

    test("testNameAccessor", () {
      var proxy = Proxy("TestProxy");
      expect(proxy.proxyName, equals("TestProxy"));
    });

    test("testDataAccessors", () {
      final proxy = Proxy("colors");
      proxy.data = ["red", "green", "blue"];

      List<String> data = proxy.data;
      expect(proxy.data, same(data));
    });

    test("testConstructor", () {
      final proxy = Proxy("colors", ["red", "green", "blue"]);
      expect(proxy.proxyName, equals("colors"));
      List<String> data = proxy.data;
      
      expect(data.length, equals(3), reason: "Expecting data.length == 3");
      expect(data[0], equals("red"), reason: "Expecting data[0] == 'red'");
      expect(data[1], equals("green"), reason: "Expecting data[1] == 'green'");
      expect(data[2], equals("blue"), reason: "Expecting data[2] == 'blue'");
    });

  });
}
