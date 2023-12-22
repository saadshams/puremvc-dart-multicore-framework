import "package:puremvc/puremvc.dart";
import "package:test/test.dart";

void main() {
  group("TestMediator", () {

    test("testDefaultNameAccessor", () {
      final mediator = Mediator();
      expect(mediator.mediatorName, equals(Mediator.NAME));
    });

    test("testNameAccessor", () {
      var mediator = Mediator("TestMediator");
      expect(mediator.mediatorName, equals("TestMediator"));
    });

    test("testViewAccessor", () {
      final view = Object();
      final mediator = Mediator(Mediator.NAME, view);

      expect(mediator.viewComponent, isNotNull);
      expect(mediator.viewComponent, same(view));
    });

  });
}
