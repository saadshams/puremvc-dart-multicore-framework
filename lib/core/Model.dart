//
//  Controller.swift
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

class Model implements IModel {
  static const String MULTITON_MSG = "Model instance for this Multiton key already constructed!";

  static Map<String, IModel> instanceMap = {};

  late String multitonKey;

  late Map<String, IProxy> proxyMap;

  Model(String key) {
    if (instanceMap.containsKey(key)) throw Exception(MULTITON_MSG);
    multitonKey = key;
    instanceMap[multitonKey] = this;
    proxyMap = {};
    initializeModel();
  }

  void initializeModel() {}

  @override
  void registerProxy(IProxy proxy) {
    proxy.initializeNotifier(multitonKey);
    proxyMap[proxy.proxyName] = proxy;
    proxy.onRegister();
  }

  @override
  IProxy? retrieveProxy(String proxyName) {
    return proxyMap[proxyName];
  }

  @override
  bool hasProxy(String proxyName) {
    return proxyMap.containsKey(proxyName);
  }

  @override
  IProxy? removeProxy(String proxyName) {
    final proxy = proxyMap[proxyName];
    if (proxy != null) {
      proxyMap.remove(proxyName);
      proxy.onRemove();
    }
    return proxy;
  }

  static IModel getInstance(String key, IModel Function(String) factory) {
    if (!instanceMap.containsKey(key)) {
      instanceMap[key] = factory(key);
    }
    return instanceMap[key]!;
  }

  static removeModel(String key) {
    instanceMap.remove(key);
  }
}
