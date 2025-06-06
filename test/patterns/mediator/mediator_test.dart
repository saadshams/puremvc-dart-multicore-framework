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
  /// Test the PureMVC Mediator class.
  ///
  /// See [IMediator] and [Mediator].
  group("TestMediator", () {

    /// Tests getting the default name using Mediator class accessor method.
    test("testDefaultNameAccessor", () {
      IMediator mediator = Mediator();
      expect(mediator.name, equals(Mediator.NAME));
    });

    /// Tests getting the name using Mediator class accessor method.
    test("testNameAccessor", () {
      // Create a new Mediator and use accessors to set the mediator name
      IMediator mediator = Mediator("TestMediator");

      // test assertions
      expect(mediator.name, equals("TestMediator"));
    });

    test("testViewAccessor", () {
      // Create a view object
      final view = Object();

      // Create a new Proxy and use accessors to set the proxy name
      IMediator mediator = Mediator(Mediator.NAME, view);

      // test assertions
      expect(mediator.view, isNotNull);
      expect(mediator.view, same(view));
    });

  });
}
