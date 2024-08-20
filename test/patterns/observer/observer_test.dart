import "package:puremvc/puremvc.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {

  group("TestObserver", () {

    test("testObserverAccessors", () {
      int observerTestVar = 0;
      final IObserver observer = Observer((notification) {
        observerTestVar = notification.body;
      }, Object());
      
      final note = Notification("ObserverTestNote", 10);
      observer.notifyObserver(note);

      expect(observerTestVar, equals(10));
    });

    test("testObserverConstructor", () {
      int observerTestVar = 0;
      final IObserver observer = Observer((notification){
        observerTestVar = notification.body;
      }, Object());

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
