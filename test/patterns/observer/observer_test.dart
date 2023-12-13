import "package:puremvc/puremvc.dart";
import "package:test/test.dart";

void main() {

  group("TestObserver", () {

    test("testObserverAccessors", () {
      final observer = Observer(null, null);

      int observerTestVar = 0;
      observer.notify = (notification) {
        observerTestVar = notification.body;
      };
      
      final note = Notification("ObserverTestNote", 10);
      observer.notifyObserver(note);

      expect(observerTestVar, equals(10));
    });

    test("testObserverConstructor", () {
      int observerTestVar = 0;
      final observer = Observer((notification){
        observerTestVar = notification.body;
      }, null);

      final note = Notification("ObserverTestNote", 5);
      observer.notifyObserver(note);

      expect(observerTestVar, equals(5));
    });

    test("testCompareNotifyContext", () {
      final object = Object();
      final observer = Observer((notification) {}, object);
      final negTestObj = Object();

      expect(observer.compareNotifyContext(negTestObj), isFalse);
      expect(observer.compareNotifyContext(object), isTrue);
    });

  });
}
