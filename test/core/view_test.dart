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
  group("TestView", () {

    test("testGetInstance", () {
      final view = View.getInstance("ViewTestKey1", (k) => View(k));
      expect(view, isNotNull);
      expect(view, isA<View>());
    });

    var viewTestVar = 0;

    viewTestMethod(INotification notification) {
      viewTestVar = notification.body;
    }

    test("testRegisterAndNotifyObserver", () {
      final view = View.getInstance("ViewTestKey2", (k) => View(k));

      final observer = Observer(viewTestMethod, Object());
      view.registerObserver(ViewTestNote.NAME, observer);

      var note = ViewTestNote.create(10);
      view.notifyObservers(note);

      expect(viewTestVar, equals(10), reason: "Expecting viewTestVar = 10");
    });

    test("testRegisterAndRetrieveMediator", () {
      final view = View.getInstance("ViewTestKey3", (k) => View(k));

      final viewTestMediator = ViewTestMediator();
      view.registerMediator(viewTestMediator);

      final mediator = view.retrieveMediator(ViewTestMediator.NAME);
      expect(mediator, isA<ViewTestMediator>());
    });

    test("hasMediator", () {
        final view = View.getInstance("ViewTestKey4", (k) => View(k));
        final mediator = Mediator("hasMediatorTest");
        view.registerMediator(mediator);

        expect(view.hasMediator("hasMediatorTest"), isTrue, reason: "Expecting view.hasMediator('hasMediatorTest') == true");
        view.removeMediator("hasMediatorTest");
        expect(view.hasMediator("hasMediatorTest"), isFalse, reason: "Expecting view.hasMediator('hasMediatorTest') == false");
    });

    test("testRegisterAndRemoveMediator", () {
      final view = View.getInstance("ViewTestKey5", (k) => View(k));
      final mediator = Mediator("testing");
      view.registerMediator(mediator);

      final removedMediator = view.removeMediator("testing")!;

      expect(removedMediator.name, equals("testing"), reason: "Expecting removedMediator.getMediatorName() == 'testing'");
      
      expect(view.retrieveMediator("testing"), isNull, reason: "Expecting view.retrieveMediator( 'testing' ) == null");
    });

    test("testOnRegisterAndOnRemove", () {
      final view = View.getInstance("ViewTestKey6", (k) => View(k));

      final mediator = ViewTestMediator4();
      view.registerMediator(mediator);

      expect(ViewTest.onRegisterCalled, isTrue, reason: "Expecting onRegisterCalled == true");

      view.removeMediator(ViewTestMediator4.NAME);

      expect(ViewTest.onRemoveCalled, isTrue, reason: "Expecting onRemoveCalled == true");
    });

    test("testSuccessiveRegisterAndRemoveMediator", () {
      final view = View.getInstance("ViewTestKey7", (k) => View(k));
      view.registerMediator(ViewTestMediator());

      expect(view.retrieveMediator(ViewTestMediator.NAME), isA<ViewTestMediator>(), reason: "Expecting view.retrieveMediator( ViewTestMediator.NAME ) is ViewTestMediator");
      view.removeMediator(ViewTestMediator.NAME);

      expect(view.retrieveMediator(ViewTestMediator.NAME), isNull, reason: "Expecting view.retrieveMediator( ViewTestMediator.NAME ) == null");

      expect(view.removeMediator(ViewTestMediator.NAME), isNull, reason: "Expecting view.removeMediator( ViewTestMediator.NAME ) doesn't crash");
      
      view.registerMediator(ViewTestMediator());

      expect(view.retrieveMediator(ViewTestMediator.NAME), isA<ViewTestMediator>(), reason: "Expecting view.retrieveMediator( ViewTestMediator.NAME ) is ViewTestMediator");

      view.removeMediator(ViewTestMediator.NAME);

      expect(view.retrieveMediator(ViewTestMediator.NAME), isNull, reason: "Expecting view.retrieveMediator( ViewTestMediator.NAME ) == null");
    });

    test("testRemoveMediatorAndSubsequentNotify", () {
      final view = View.getInstance("ViewTestKey8", (k) => View(k));

      view.registerMediator(ViewTestMediator2());

      view.notifyObservers(Notification(ViewTest.NOTE_1));
      expect(ViewTest.lastNotification, equals(ViewTest.NOTE_1), reason: "Expecting lastNotification == NOTE1");

      view.notifyObservers(Notification(ViewTest.NOTE_2));
      expect(ViewTest.lastNotification, ViewTest.NOTE_2, reason: "Expecting lastNotification == NOTE2");
      
      view.removeMediator(ViewTestMediator2.NAME);
      
      expect(view.retrieveMediator(ViewTestMediator2.NAME), isNull, reason: "Expecting view.retrieveMediator( ViewTestMediator2.NAME ) == null");

      ViewTest.lastNotification = "";

      view.notifyObservers(Notification(ViewTest.NOTE_1));
      expect(ViewTest.lastNotification != ViewTest.NOTE_1, isTrue, reason: "Expecting lastNotification != NOTE1");

      view.notifyObservers(Notification(ViewTest.NOTE_2));
      expect(ViewTest.lastNotification != ViewTest.NOTE_2, isTrue, reason: "Expecting lastNotification != NOTE2");
    });

    test("testRemoveOneOfTwoMediatorsAndSubsequentNotify", () {
      final view = View.getInstance("ViewTestKey9", (k) => View(k));

      view.registerMediator(ViewTestMediator2());

      view.registerMediator(ViewTestMediator3());

      view.notifyObservers(Notification(ViewTest.NOTE_1));
      expect(ViewTest.lastNotification, equals(ViewTest.NOTE_1), reason: "Expecting lastNotification == NOTE1");

      view.notifyObservers(Notification(ViewTest.NOTE_2));
      expect(ViewTest.lastNotification, equals(ViewTest.NOTE_2), reason: "Expecting lastNotification == NOTE2");

      view.notifyObservers(Notification(ViewTest.NOTE_3));
      expect(ViewTest.lastNotification, equals(ViewTest.NOTE_3), reason: "Expecting lastNotification == NOTE3");

      view.removeMediator(ViewTestMediator2.NAME);
      expect(view.retrieveMediator(ViewTestMediator2.NAME), isNull, reason: "Expecting view.retrieveMediator( ViewTestMediator2.NAME ) == null");

      ViewTest.lastNotification = "";

      view.notifyObservers(Notification(ViewTest.NOTE_1));
      expect(ViewTest.lastNotification != ViewTest.NOTE_1, isTrue, reason: "Expecting lastNotification != NOTE1");

      view.notifyObservers(Notification(ViewTest.NOTE_2));
      expect(ViewTest.lastNotification != ViewTest.NOTE_2, isTrue, reason: "Expecting lastNotification != NOTE2");

      view.notifyObservers(Notification(ViewTest.NOTE_3));
      expect(ViewTest.lastNotification == ViewTest.NOTE_3, isTrue, reason: "Expecting lastNotification == NOTE3");
    });

    test("testMediatorReregistration", () {
      final view = View.getInstance("ViewTestKey10", (k) => View(k));
      view.registerMediator(ViewTestMediator5());

      view.registerMediator(ViewTestMediator5());

      ViewTest.counter - 0;
      view.notifyObservers(Notification(ViewTest.NOTE_5));
      expect(ViewTest.counter, equals(1), reason: "Expecting counter == 1");

      view.removeMediator(ViewTestMediator5.NAME);

      expect(view.retrieveMediator(ViewTestMediator5.NAME), isNull, reason: "Expecting view.retrieveMediator( ViewTestMediator5.NAME ) == null");

      ViewTest.counter = 0;
      view.notifyObservers(Notification(ViewTest.NOTE_5));

      expect(ViewTest.counter, equals(0), reason: "Expecting counter == 0");
    });

    test("testModifyObserverListDuringNotification", () {
      final view = View.getInstance("ViewTestKey11", (k) => View(k));

      view.registerMediator(ViewTestMediator6("${ViewTestMediator6.NAME}/1"));
      view.registerMediator(ViewTestMediator6("${ViewTestMediator6.NAME}/2"));
      view.registerMediator(ViewTestMediator6("${ViewTestMediator6.NAME}/3"));
      view.registerMediator(ViewTestMediator6("${ViewTestMediator6.NAME}/4"));
      view.registerMediator(ViewTestMediator6("${ViewTestMediator6.NAME}/5"));
      view.registerMediator(ViewTestMediator6("${ViewTestMediator6.NAME}/6"));
      view.registerMediator(ViewTestMediator6("${ViewTestMediator6.NAME}/7"));
      view.registerMediator(ViewTestMediator6("${ViewTestMediator6.NAME}/8"));

      ViewTest.counter = 0;
      view.notifyObservers(Notification(ViewTest.NOTE_6));
      // expect(ViewTest.counter, equals(8), reason: "Expecting counter == 8");

      ViewTest.counter = 0;
      view.notifyObservers(Notification(ViewTest.NOTE_6));
      expect(ViewTest.counter, equals(0), reason: "Expecting counter == 0");
    });

  });
}

class ViewTest {
  static const String NOTE_1 = "Notification1";
  static const String NOTE_2 = "Notification2";
  static const String NOTE_3 = "Notification3";
  static const String NOTE_4 = "Notification4";
  static const String NOTE_5 = "Notification5";
  static const String NOTE_6 = "Notification6";

  static int counter = 0;
  static String lastNotification = "";
  static bool onRegisterCalled = false;
  static bool onRemoveCalled = false;
}

class ViewTestNote extends Notification {
  static const String NAME = "ViewTestNote";

  ViewTestNote(String name, dynamic body) : super(name, body);

  static INotification create(dynamic body) {
    return ViewTestNote(NAME, body);
  }
}

class ViewTestMediator extends Mediator {
  static const String NAME = "ViewTestMediator";

  ViewTestMediator(): super(NAME);

  @override
  List<String> listNotificationInterests() {
    return ["ABC", "DEF", "GHI"];
  }
}

class ViewTestMediator2 extends Mediator {
  static const String NAME = "ViewTestMediator2";

  ViewTestMediator2(): super(NAME);

  @override
  List<String> listNotificationInterests() {
    return [ViewTest.NOTE_1, ViewTest.NOTE_2];
  }

  @override
  handleNotification(INotification notification) {
    ViewTest.lastNotification = notification.name;
  }
}

class ViewTestMediator3 extends Mediator {
  static const String NAME = "ViewTestMediator3";

  ViewTestMediator3(): super(NAME);

  @override
  List<String> listNotificationInterests() {
    return [ViewTest.NOTE_3];
  }

  @override
  handleNotification(INotification notification) {
    ViewTest.lastNotification = notification.name;
  }
}

class ViewTestMediator4 extends Mediator {
  static const String NAME = "ViewTestMediator4";

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

class ViewTestMediator5 extends Mediator {
  static const String NAME = "ViewTestMediator5";

  ViewTestMediator5(): super(NAME);

  @override
  List<String> listNotificationInterests() {
    return [ViewTest.NOTE_5];
  }

  @override
  handleNotification(INotification notification) {
    ViewTest.counter++;
  }
}

class ViewTestMediator6 extends Mediator {
  static const String NAME = "ViewTestMediator6";

  ViewTestMediator6(String name): super(name);

  @override
  List<String> listNotificationInterests() {
    return [ViewTest.NOTE_6];
  }

  @override
  handleNotification(INotification notification) {
    // facade.removeMediator(name);
  }

  @override
  void onRemove() {
    ViewTest.counter++;
  }
}