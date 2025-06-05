//
//  IModel.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// The interface definition for a PureMVC MultiCore Model.
///
/// In PureMVC, [IModel] implementors provide access to [IProxy] objects by named lookup.
///
/// An [IModel] assumes these responsibilities:
///
/// - Maintain a cache of [IProxy] instances.
/// - Provide methods for registering, retrieving, and removing [IProxy] instances.
///
/// Your application must register [IProxy] instances with the [IModel].
/// Typically, you use an [ICommand] to create and register [IProxy] instances
/// once the [IFacade] has initialized the core actors.
///
/// See also:
/// - [IProxy]
/// - [IFacade]
abstract class IModel {

  /// Registers an [IProxy] instance with the [IModel].
  ///
  /// @param proxy the [IProxy] instance to register.
  void registerProxy(IProxy proxy);

  /// Returns the [IProxy] instance previously registered with the given name.
  ///
  /// @param proxyName the name of the [IProxy] instance to retrieve.
  /// @returns [IProxy] the registered instance.
  IProxy? retrieveProxy(String proxyName);

  /// Checks whether an [IProxy] is registered with the [IModel].
  ///
  /// @param proxyName the name of the [IProxy] to check.
  /// @returns Whether a proxy with that name is registered.
  bool hasProxy(String proxyName);

  /// Removes the [IProxy] instance with the given name from the [IModel].
  ///
  /// @param proxyName the name of the [IProxy] to remove.
  /// @returns [IProxy] the removed instance.
  IProxy? removeProxy(String proxyName);

}
