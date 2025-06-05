//
//  Controller.swift
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

class Controller implements IController {
  static const String MULTITON_MSG = "Controller instance for this Multiton key already constructed!";

  static Map<String, IController> _instanceMap = {};

  late String multitonKey;

  late Map<String, ICommand Function()> commandMap;

  late IView view;

  Controller(String key) {
    if (_instanceMap.containsKey(key)) throw Exception(MULTITON_MSG);
    multitonKey = key;
    _instanceMap[multitonKey] = this;
    commandMap = {};
    initializeController();
  }

  initializeController() {
    view = View.getInstance(multitonKey, (k) => View(k));
  }

  static IController getInstance(String key, IController Function(String) factory) {
    if (!_instanceMap.containsKey(key)) {
      _instanceMap[key] = factory(key);
    }
    return _instanceMap[key]!;
  }

  @override
  void executeCommand(INotification notification) {
    final factory = commandMap[notification.name];
    if (factory == null) return;
    final command = factory();
    command.initializeNotifier(multitonKey);
    command.execute(notification);
  }

  @override
  void registerCommand(String notificationName, ICommand Function() factory) {
    if (!commandMap.containsKey(notificationName)) {
      view.registerObserver(notificationName, Observer(executeCommand, this));
    }
    commandMap[notificationName] = factory;
  }

  @override
  bool hasCommand(String notificationName) {
    return commandMap.containsKey(notificationName);
  }

  @override
  void removeCommand(String notificationName) {
    if (hasCommand(notificationName)) {
      view.removeObserver(notificationName, this);
    }
    commandMap.remove(notificationName);
  }

  static void removeController(String key) {
    _instanceMap.remove(key);
  }
}
