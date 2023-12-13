import 'package:puremvc/puremvc.dart';

abstract class IProxy extends INotifier {
  void onRegister();

  void onRemove();

  String get name;

  dynamic get data;

  set data(dynamic value);
}
