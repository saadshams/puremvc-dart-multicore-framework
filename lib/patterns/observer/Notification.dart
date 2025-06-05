//
//  Notification.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

class Notification implements INotification {
  final String _name;

  dynamic _body;

  String _type = "";

  Notification(String name, [dynamic body, String type = ""]): _name = name {
    _body = body;
    _type = type;
  }

  @override
  String get name => _name;

  @override
  dynamic get body => _body;
  @override
  set body(dynamic value) => _body = value;

  @override
  String get type => _type;
  @override
  set type(String value) => _type = value;

  @override
  String toString() {
    return 'Notification(name: $_name, body: $_body, type: $_type)';
  }
}
