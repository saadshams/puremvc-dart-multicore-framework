//
//  IProxy.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// The interface definition for a PureMVC MultiCore Proxy.
///
/// In PureMVC, [IProxy] implementors assume these responsibilities:
///
/// - Implement a common method which returns the name of the [IProxy].
/// - Provide methods for setting and getting a Data Object.
///
/// Additionally, [IProxy]s typically:
///
/// - Provide methods for manipulating the Data Object and referencing it by type.
/// - Generate [INotification]s when their Data Object changes.
/// - Expose their name as a [static final String] called [NAME].
/// - Encapsulate interaction with local or remote services used to fetch and persist data.
///
/// See [IModel].
abstract class IProxy extends INotifier {

  /// Called by the [IModel] when the [IProxy] is registered.
  void onRegister();

  /// Called by the [IModel] when the [IProxy] is removed.
  void onRemove();

  /// This [IProxy]'s [name].
  String get name;

  /// This [IProxy]'s [data].
  dynamic get data;
  set data(dynamic value);
}
