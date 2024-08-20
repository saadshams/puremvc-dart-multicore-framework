abstract class INotification {
  String get name;

  dynamic get body;

  set body(dynamic value);

  String get type;

  set type(String value);
}
