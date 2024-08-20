import "package:puremvc/puremvc.dart";
import "package:test/test.dart";

void main() {
  group("TestNotification", () {

    test("testNameAccessors", () {
      final note = Notification("TestNote");
      expect(note.name, equals("TestNote"));
    });

    test("testBodyAccessors", () {
      final note = Notification("TestNote");
      note.body = 5;

      expect(note.body, equals(5));
    });

    test("testConstructor", () {
      final note = Notification("TestNote", 5, "TestNoteType");
      expect(note.name, equals("TestNote"));
      expect(note.body, equals(5));
      expect(note.type, equals("TestNoteType"));
    });

  });
}
