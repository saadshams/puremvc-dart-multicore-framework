//
//  model.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// A PureMVC MultiCore [IModel] implementation.
///
/// In PureMVC, [IModel] implementors provide access to [IProxy] objects by name.
///
/// An [IModel] assumes the following responsibilities:
///
/// - Maintaining a cache of [IProxy] instances.
/// - Providing methods for registering, retrieving, and removing [IProxy] instances.
///
/// Your application must register [IProxy] instances with the [IModel]. Typically,
/// an [ICommand] creates and registers [IProxy] instances after the [IFacade] has
/// initialized the core actors.
///
/// See also: [IProxy], [IFacade]
class Model implements IModel {
  /// Message Constants
  static const String MULTITON_MSG = "Model instance for this Multiton key already constructed!";

  /// The [IModel] Multiton instance map
  static Map<String, IModel> _instanceMap = {};

  /// The Multiton Key for this Core
  late String _multitonKey;

  /// Mapping of proxyNames to IProxy instances
  late Map<String, IProxy> _proxyMap;

  /// Constructor.
  ///
  /// This [IModel] implementation is a Multiton, so you should not call the constructor
  /// directly. Instead, use the static [getInstance] method.
  ///
  /// @param key The unique Multiton key for this instance.
  /// @throws [Exception] if an instance for this Multiton key has already been constructed.
  Model(String key) {
    if (_instanceMap.containsKey(key)) throw Exception(MULTITON_MSG);
    _multitonKey = key;
    _instanceMap[_multitonKey] = this;
    _proxyMap = {};
    initializeModel();
  }

  /// Initialize the [IModel] instance.
  ///
  /// Called automatically by the constructor. Override this method in a subclass
  /// to initialize the [IModel] Multiton instance without overriding the constructor.
  void initializeModel() {

  }

  /// [IModel] Multiton factory method.
  ///
  /// Returns the [IModel] Multiton instance associated with the given [key].
  /// If no instance exists for the [key], a new one is created by calling [factory].
  ///
  /// @param key The unique key identifying the Multiton instance.
  /// @param factory A function that creates a new [IModel] instance for the given [key].
  /// @returns [IModel] The instance associated with the specified [key].
  static IModel getInstance(String key, IModel Function(String) factory) {
    if (!_instanceMap.containsKey(key)) {
      _instanceMap[key] = factory(key);
    }
    return _instanceMap[key]!;
  }

  /// Registers an [IProxy] instance with the [IModel].
  ///
  /// @param proxy The [IProxy] instance to register with the model.
  @override
  void registerProxy(IProxy proxy) {
    proxy.initializeNotifier(_multitonKey);
    _proxyMap[proxy.name] = proxy;
    proxy.onRegister();
  }

  /// Retrieves an [IProxy] instance from the [IModel].
  ///
  /// @param proxyName The name of the [IProxy] instance to retrieve.
  /// @returns [IProxy] The instance registered with the given [proxyName], or `null` if not found.
  @override
  IProxy? retrieveProxy(String proxyName) {
    return _proxyMap[proxyName];
  }

  /// Checks if an [IProxy] is registered with the [IModel].
  ///
  /// @param proxyName The name of the [IProxy] instance to check.
  /// @returns Whether an [IProxy] is currently registered with the given [proxyName].
  @override
  bool hasProxy(String proxyName) {
    return _proxyMap.containsKey(proxyName);
  }

  /// Removes an [IProxy] instance from the [IModel].
  ///
  /// @param proxyName The name of the [IProxy] instance to remove.
  /// @returns [IProxy] that was removed from the [IModel], or `null` if none existed.
  @override
  IProxy? removeProxy(String proxyName) {
    IProxy? proxy = _proxyMap[proxyName];
    if (proxy != null) {
      _proxyMap.remove(proxyName);
      proxy.onRemove();
    }
    return proxy;
  }

  /// Removes an [IModel] instance.
  ///
  /// @param key The multitonKey of the [IModel] instance to remove.
  static removeModel(String key) {
    _instanceMap.remove(key);
  }

}
