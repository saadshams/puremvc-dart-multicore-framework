//
//  view_test.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import "package:puremvc/puremvc.dart";
import "package:test/test.dart";

void main() {

  /// Test the PureMVC View class.
  group("TestView", () {

    /// Tests the View Multiton Factory Method
    test("testGetInstance", () {
      // Test Factory Method
      IView view = View.getInstance("ViewTestKey1", (k) => View(k));

      // test assertions
      expect(view, isNotNull);
      expect(view, isA<View>());

      // Call getInstance() again
      IView again = View.getInstance("ViewTestKey1", (k) => View(k));

      // Make sure the same instance was returned
      expect(view, same(again));
    });

    // A test variable that proves the viewTestMethod was
    // invoked by the View.
    var viewTestVar = 0;

    // A utility method to test the notification of Observers by the view
    viewTestMethod(INotification notification) {
      // set the local viewTestVar to the number on the event payload
      viewTestVar = notification.body;
    }

    /// Tests registration and notification of observers.
    ///
    /// An `Observer` is created to callback the `viewTestMethod` of this
    /// `ViewTest` instance. This observer is registered with the `View` to be
    /// notified of `'ViewTestEvent'` events.
    ///
    /// Such an event is created, and a value is set on its payload. Then the `View`
    /// is instructed to notify interested observers of the event.
    ///
    /// The `View` calls the observer’s `notifyObserver` method, which in turn
    /// calls the `viewTestMethod` on this instance of the `ViewTest` class.
    /// That method sets an instance variable to the value passed in via the
    /// event payload. The test asserts that this variable matches the original
    /// payload value from the `'ViewTestEvent'`.
    test("testRegisterAndNotifyObserver", () {
      // Get the Multiton View instance
      IView view = View.getInstance("ViewTestKey2", (k) => View(k));

      // Create observer, passing in notification method and context
      IObserver observer = Observer(viewTestMethod, Object());

      // Register Observer's interest in a particular Notification with the View
      view.registerObserver("ViewTestNote", observer);

      // Create a ViewTestNote, setting
      // a body value, and tell the View to notify
      // Observers. Since the Observer is this class
      // and the notification method is viewTestMethod,
      // successful notification will result in our local
      // viewTestVar being set to the value we pass in
      // on the note body.
      final note = Notification("ViewTestNote", 10);
      view.notifyObservers(note);

      // test assertions
      expect(viewTestVar, equals(10), reason: "Expecting viewTestVar = 10");
    });

    /// Tests registering and retrieving a mediator with
    /// the View.
    test("testRegisterAndRetrieveMediator", () {
      // Get the Multiton View instance
      IView view = View.getInstance("ViewTestKey3", (k) => View(k));

      // Create and register the test mediator
      final viewTestMediator = ViewTestMediator();
      view.registerMediator(viewTestMediator);

      // Retrieve the component
      IMediator? mediator = view.retrieveMediator(ViewTestMediator.NAME);

      // test assertions
      expect(mediator, isA<ViewTestMediator>(), reason: "Expecting component is ViewTestMediator");
    });

    /// Tests the hasMediator Method
    test("hasMediator", () {
        // register a Mediator
        IView view = View.getInstance("ViewTestKey4", (k) => View(k));

        // Create and register the test mediator
        IMediator mediator = Mediator("hasMediatorTest");
        view.registerMediator(mediator);

        // assert that the view.hasMediator method returns true
        // for that mediator name
        expect(view.hasMediator("hasMediatorTest"), isTrue, reason: "Expecting view.hasMediator('hasMediatorTest') == true");

        view.removeMediator("hasMediatorTest");

        // assert that the view.hasMediator method returns false
        // for that mediator name
        expect(view.hasMediator("hasMediatorTest"), isFalse, reason: "Expecting view.hasMediator('hasMediatorTest') == false");
    });

    /// Tests registering and removing a mediator
    test("testRegisterAndRemoveMediator", () {
      // Get the Multiton View instance
      IView view = View.getInstance("ViewTestKey5", (k) => View(k));

      // Create and register the test mediator
      IMediator mediator = Mediator("testing");
      view.registerMediator(mediator);

      // Remove the component
      IMediator? removedMediator = view.removeMediator("testing");

      // assert that we have removed the appropriate mediator
      expect(removedMediator?.name, equals("testing"), reason: "Expecting removedMediator.getMediatorName() == 'testing'");

      // assert that the mediator is no longer retrievable
      expect(view.retrieveMediator("testing"), isNull, reason: "Expecting view.retrieveMediator( 'testing' ) == null");
    });

    /// Tests that the View calls the onRegister and onRemove methods
    test("testOnRegisterAndOnRemove", () {
      // Get the Multiton View instance
      IView view = View.getInstance("ViewTestKey6", (k) => View(k));

      // Create and register the test mediator
      IMediator mediator = ViewTestMediator4();
      view.registerMediator(mediator);

      // assert that onRegister was called, and the mediator responded by setting our boolean
      expect(ViewTest.onRegisterCalled, isTrue, reason: "Expecting onRegisterCalled == true");

      // Remove the component
      view.removeMediator(ViewTestMediator4.NAME);

      // assert that the mediator is no longer retrievable
      expect(ViewTest.onRemoveCalled, isTrue, reason: "Expecting onRemoveCalled == true");
    });

    /// Tests successive register and remove of same mediator.
    test("testSuccessiveRegisterAndRemoveMediator", () {
      // Get the Multiton View instance
      IView view = View.getInstance("ViewTestKey7", (k) => View(k));

      // Create and register the test mediator,
      // but not so we have a reference to it
      view.registerMediator(ViewTestMediator());

      // test that we can retrieve it
      expect(view.retrieveMediator(ViewTestMediator.NAME), isA<ViewTestMediator>(), reason: "Expecting view.retrieveMediator( ViewTestMediator.NAME ) is ViewTestMediator");

      // Remove the Mediator
      view.removeMediator(ViewTestMediator.NAME);

      // test that retrieving it now returns null
      expect(view.retrieveMediator(ViewTestMediator.NAME), isNull, reason: "Expecting view.retrieveMediator( ViewTestMediator.NAME ) == null");

      // test that removing the mediator again once its gone doesn't cause crash
      expect(view.removeMediator(ViewTestMediator.NAME), isNull, reason: "Expecting view.removeMediator( ViewTestMediator.NAME ) doesn't crash");

      // Create and register another instance of the test mediator,
      view.registerMediator(ViewTestMediator());
      expect(view.retrieveMediator(ViewTestMediator.NAME), isA<ViewTestMediator>(), reason: "Expecting view.retrieveMediator( ViewTestMediator.NAME ) is ViewTestMediator");

      // Remove the Mediator
      view.removeMediator(ViewTestMediator.NAME);

      // test that retrieving it now returns null
      expect(view.retrieveMediator(ViewTestMediator.NAME), isNull, reason: "Expecting view.retrieveMediator( ViewTestMediator.NAME ) == null");
    });

    /// Tests registering a mediator for two different notifications,
    /// then removing the mediator from the view, and verifying that
    /// neither notification triggers the mediator.
    /// This test was added to cover the fix introduced in version 1.7.
    test("testRemoveMediatorAndSubsequentNotify", () {
      // Get the Multiton View instance
      IView view = View.getInstance("ViewTestKey8", (k) => View(k));

      // Create and register the test mediator to be removed.
      view.registerMediator(ViewTestMediator2());

      // test that notifications work
      view.notifyObservers(Notification(ViewTest.NOTE_1));
      expect(ViewTest.lastNotification, equals(ViewTest.NOTE_1), reason: "Expecting lastNotification == NOTE1");

      view.notifyObservers(Notification(ViewTest.NOTE_2));
      expect(ViewTest.lastNotification, ViewTest.NOTE_2, reason: "Expecting lastNotification == NOTE2");

      // Remove the Mediator
      view.removeMediator(ViewTestMediator2.NAME);

      // test that retrieving it now returns null
      expect(view.retrieveMediator(ViewTestMediator2.NAME), isNull, reason: "Expecting view.retrieveMediator( ViewTestMediator2.NAME ) == null");

      // test that notifications no longer work
      // (ViewTestMediator2 is the one that sets lastNotification
      // on this component, and ViewTestMediator)
      ViewTest.lastNotification = "";

      view.notifyObservers(Notification(ViewTest.NOTE_1));
      expect(ViewTest.lastNotification != ViewTest.NOTE_1, isTrue, reason: "Expecting lastNotification != NOTE1");

      view.notifyObservers(Notification(ViewTest.NOTE_2));
      expect(ViewTest.lastNotification != ViewTest.NOTE_2, isTrue, reason: "Expecting lastNotification != NOTE2");
    });

    /// Tests removing one of two registered mediators and verifying
    /// that the remaining mediator still responds to notifications.
    test("testRemoveOneOfTwoMediatorsAndSubsequentNotify", () {
      // Get the Multiton View instance
      IView view = View.getInstance("ViewTestKey9", (k) => View(k));

      // Create and register that responds to notifications 1 and 2
      view.registerMediator(ViewTestMediator2());

      // Create and register that responds to notification 3
      view.registerMediator(ViewTestMediator3());

      // test that all notifications work
      view.notifyObservers(Notification(ViewTest.NOTE_1));
      expect(ViewTest.lastNotification, equals(ViewTest.NOTE_1), reason: "Expecting lastNotification == NOTE1");

      view.notifyObservers(Notification(ViewTest.NOTE_2));
      expect(ViewTest.lastNotification, equals(ViewTest.NOTE_2), reason: "Expecting lastNotification == NOTE2");

      view.notifyObservers(Notification(ViewTest.NOTE_3));
      expect(ViewTest.lastNotification, equals(ViewTest.NOTE_3), reason: "Expecting lastNotification == NOTE3");

      // Remove the Mediator that responds to 1 and 2
      view.removeMediator(ViewTestMediator2.NAME);

      // test that retrieving it now returns null
      expect(view.retrieveMediator(ViewTestMediator2.NAME), isNull, reason: "Expecting view.retrieveMediator( ViewTestMediator2.NAME ) == null");

      // test that notifications no longer work
      // for notifications 1 and 2, but still work for 3
      ViewTest.lastNotification = "";

      view.notifyObservers(Notification(ViewTest.NOTE_1));
      expect(ViewTest.lastNotification != ViewTest.NOTE_1, isTrue, reason: "Expecting lastNotification != NOTE1");

      view.notifyObservers(Notification(ViewTest.NOTE_2));
      expect(ViewTest.lastNotification != ViewTest.NOTE_2, isTrue, reason: "Expecting lastNotification != NOTE2");

      view.notifyObservers(Notification(ViewTest.NOTE_3));
      expect(ViewTest.lastNotification == ViewTest.NOTE_3, isTrue, reason: "Expecting lastNotification == NOTE3");
    });

    /// Tests registering the same mediator twice.
    ///
    /// A subsequent notification should trigger only one response.
    /// Also verifies that re-registration does not result in multiple
    /// observers being created. After removing the mediator, there
    /// should be no further responses.
    test("testMediatorReregistration", () {
      // Get the Multiton View instance
      IView view = View.getInstance("ViewTestKey10", (k) => View(k));

      // test that the counter is only incremented once (mediator 5's response)
      final counter = {"value": 0};

      // Create and register that responds to notification 5
      view.registerMediator(ViewTestMediator5(counter));

      // try to register another instance of that mediator (uses the same NAME constant).
      view.registerMediator(ViewTestMediator5(counter));

      view.notifyObservers(Notification(ViewTest.NOTE_5, counter));
      expect(counter["value"], equals(1), reason: "Expecting counter == 1");

      // Remove the Mediator
      view.removeMediator(ViewTestMediator5.NAME);

      // test that retrieving it now returns null
      expect(view.retrieveMediator(ViewTestMediator5.NAME), isNull, reason: "Expecting view.retrieveMediator( ViewTestMediator5.NAME ) == null");

      // test that the counter is no longer incremented
      counter["value"] = 0;
      view.notifyObservers(Notification(ViewTest.NOTE_5));
      expect(counter["value"], equals(0), reason: "Expecting counter == 0");
    });

    /// Tests that the observer list can be safely modified during notification,
    /// and all observers are still properly notified.
    ///
    /// This scenario commonly occurs when multiple mediators respond to the same
    /// notification by removing themselves during the notification process.
    test("testModifyObserverListDuringNotification", () {
      // Get the Multiton View instance
      IView view = View.getInstance("ViewTestKey11", (k) => View(k));

      final counter = {"value": 0};

      // Create and register several mediator instances that respond to notification 6
      // by removing themselves, which will cause the observer list for that notification
      // to change. versions prior to MultiCore Version 2.0.5 will see every other mediator
      // fails to be notified.
      view.registerMediator(ViewTestMediator6("${ViewTestMediator6.NAME}/1", counter));
      view.registerMediator(ViewTestMediator6("${ViewTestMediator6.NAME}/2", counter));
      view.registerMediator(ViewTestMediator6("${ViewTestMediator6.NAME}/3", counter));
      view.registerMediator(ViewTestMediator6("${ViewTestMediator6.NAME}/4", counter));
      view.registerMediator(ViewTestMediator6("${ViewTestMediator6.NAME}/5", counter));
      view.registerMediator(ViewTestMediator6("${ViewTestMediator6.NAME}/6", counter));
      view.registerMediator(ViewTestMediator6("${ViewTestMediator6.NAME}/7", counter));
      view.registerMediator(ViewTestMediator6("${ViewTestMediator6.NAME}/8", counter));

      // clear the counter
      counter["value"] = 0;

      // send the notification. each of the above mediators will respond by removing
      // themselves and incrementing the counter by 1. This should leave us with a
      // count of 8, since 8 mediators will respond.
      view.notifyObservers(Notification(ViewTest.NOTE_6, counter));
      // verify the count is correct
      expect(counter['value'], equals(8), reason: "Expecting counter == 8");

      // clear the counter
      counter['value'] = 0;
      view.notifyObservers(Notification(ViewTest.NOTE_6));
      // verify the count is 0
      expect(counter['value'], equals(0), reason: "Expecting counter == 0");
    });

  });
}

class ViewTest {
  // The name of this Notification.
  static const String NOTE_1 = "Notification1";
  static const String NOTE_2 = "Notification2";
  static const String NOTE_3 = "Notification3";
  static const String NOTE_4 = "Notification4";
  static const String NOTE_5 = "Notification5";
  static const String NOTE_6 = "Notification6";

  static String lastNotification = "";
  static bool onRegisterCalled = false;
  static bool onRemoveCalled = false;
}

/// A mediator class used by `ViewTest`.
///
/// @see ViewTest
class ViewTestMediator extends Mediator {
  // The Mediator name
  static const String NAME = "ViewTestMediator";

  // Constructor
  ViewTestMediator(): super(NAME);

  // be sure that the mediator has some Observers created
  // in order to test removeMediator
  @override
  List<String> listNotificationInterests() {
    return ["ABC", "DEF", "GHI"];
  }
}

/// A mediator class used by `ViewTest`.
///
/// See also: [ViewTest]
class ViewTestMediator2 extends Mediator {
  // The Mediator name
  static const String NAME = "ViewTestMediator2";

  // Constructor
  ViewTestMediator2(): super(NAME);

  // be sure that the mediator has some Observers created
  // in order to test removeMediator
  @override
  List<String> listNotificationInterests() {
    return [ViewTest.NOTE_1, ViewTest.NOTE_2];
  }

  @override
  handleNotification(INotification notification) {
    ViewTest.lastNotification = notification.name;
  }
}

/// A mediator class used by `ViewTest`.
///
/// See also: [ViewTest]
class ViewTestMediator3 extends Mediator {
  // The Mediator name
  static const String NAME = "ViewTestMediator3";

  // Constructor
  ViewTestMediator3(): super(NAME);

  // be sure that the mediator has some Observers created
  // in order to test removeMediator
  @override
  List<String> listNotificationInterests() {
    return [ViewTest.NOTE_3];
  }

  @override
  handleNotification(INotification notification) {
    ViewTest.lastNotification = notification.name;
  }
}

/// A mediator class used by `ViewTest`.
///
/// See also: [ViewTest]
class ViewTestMediator4 extends Mediator {
  // The Mediator name
  static const String NAME = "ViewTestMediator4";

  // Constructor
  ViewTestMediator4(): super(NAME);

  @override
  void onRegister() {
    ViewTest.onRegisterCalled = true;
  }

  @override
  void onRemove() {
    ViewTest.onRemoveCalled = true;
  }
}

/// A mediator class used by `ViewTest`.
///
/// See also: [ViewTest]
class ViewTestMediator5 extends Mediator {
  // The Mediator name
  static const String NAME = "ViewTestMediator5";

  // Constructor
  ViewTestMediator5(dynamic view): super(NAME, view);

  @override
  List<String> listNotificationInterests() {
    return [ViewTest.NOTE_5];
  }

  @override
  handleNotification(INotification notification) {
    this.view['value']++;
  }
}

/// A mediator class used by `ViewTest`.
///
/// See also: [ViewTest]
class ViewTestMediator6 extends Mediator {
  // The Mediator name
  static const String NAME = "ViewTestMediator6";

  // Constructor
  ViewTestMediator6(String name, dynamic view): super(name, view);

  @override
  List<String> listNotificationInterests() {
    return [ViewTest.NOTE_6];
  }

  @override
  handleNotification(INotification notification) {
    facade.removeMediator(name);
  }

  @override
  void onRemove() {
    this.view['value']++;
  }
}