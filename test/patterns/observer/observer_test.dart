//
//  observer_test.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import "package:puremvc/puremvc.dart";
import "package:test/test.dart";

void main() {

  /// Tests the PureMVC Observer class.
  ///
  /// Since the Observer encapsulates the interested object's
  /// callback information, there are no getters, only setters.
  /// It is, in effect, write-only memory.
  ///
  /// Therefore, the only way to test it is to set the
  /// notification method and context and call the notifyObserver
  /// method.
  group("TestObserver", () {

    /// Tests observer class when initialized by accessor methods.
    test("testObserverAccessors", () {
      // Create observer with null args, then
      // use accessors to set notification method and context
      int observerTestVar = 0;
      final IObserver observer = Observer((notification) {
        observerTestVar = notification.body;
      }, Object());

      // create a test event, setting a payload value and notify
      // the observer with it. since the observer is this class
      // and the notification method is observerTestMethod,
      // successful notification will result in our local
      // observerTestVar being set to the value we pass in
      // on the note body.
      INotification note = Notification("ObserverTestNote", 10);
      observer.notifyObserver(note);

      // test assertions
      expect(observerTestVar, equals(10));
    });

    /// Tests observer class when initialized by constructor.
    test("testObserverConstructor", () {
      // Create observer passing in notification method and context
      int observerTestVar = 0;
      final IObserver observer = Observer((notification){
        observerTestVar = notification.body;
      }, Object());

      // create a test note, setting a body value and notify
      // the observer with it. since the observer is this class
      // and the notification method is observerTestMethod,
      // successful notification will result in our local
      // observerTestVar being set to the value we pass in
      // on the note body.
      INotification note = Notification("ObserverTestNote", 5);
      observer.notifyObserver(note);

      // test assertions
      expect(observerTestVar, equals(5));
    });

    /// Tests the compareNotifyContext method of the Observer class
    test("testCompareNotifyContext", () {
      // Create observer passing in notification method and context
      final object = Object();
      final observer = Observer((notification) {}, object);
      final negTestObj = Object();

      // test assertions
      expect(observer.compareNotifyContext(negTestObj), isFalse);
      expect(observer.compareNotifyContext(object), isTrue);
    });

  });
}
