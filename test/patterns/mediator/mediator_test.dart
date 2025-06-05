//
//  mediator_test.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import "package:puremvc/puremvc.dart";
import "package:test/test.dart";

void main() {
  group("TestMediator", () {

    test("testDefaultNameAccessor", () {
      final mediator = Mediator();
      expect(mediator.name, equals(Mediator.NAME));
    });

    test("testNameAccessor", () {
      var mediator = Mediator("TestMediator");
      expect(mediator.name, equals("TestMediator"));
    });

    test("testViewAccessor", () {
      final view = Object();
      final mediator = Mediator(Mediator.NAME, view);

      expect(mediator.view, isNotNull);
      expect(mediator.view, same(view));
    });

  });
}
