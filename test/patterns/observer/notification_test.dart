//
//  notification_test.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import "package:puremvc/puremvc.dart";
import "package:test/test.dart";

void main() {
  /// Test the PureMVC Notification class.
  ///
  /// See [Notification].
  group("TestNotification", () {

    /// Tests setting and getting the name using Notification class accessor methods.
    test("testNameAccessors", () {
      // Create a new Notification and use accessors to set the note name
      INotification note= Notification("TestNote");

      // test assertions
      expect(note.name, equals("TestNote"));
    });

    // Tests setting and getting the body using Notification class accessor methods.
    test("testBodyAccessors", () {
      // Create a new Notification and use accessors to set the body
      INotification note= Notification("TestNote");
      note.body = 5;

      // test assertions
      expect(note.body, equals(5));
    });

    // Tests setting the name and body using the Notification class Constructor.
    test("testConstructor", () {
      // Create a new Notification using the Constructor to set the note name and body
      INotification note= Notification("TestNote", 5, "TestNoteType");

      // test assertions
      expect(note.name, equals("TestNote"));
      expect(note.body, equals(5));
      expect(note.type, equals("TestNoteType"));
    });

  });
}
