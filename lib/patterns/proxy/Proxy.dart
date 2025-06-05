//
//  Proxy.dart
//  PureMVC Dart Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

import 'package:puremvc/puremvc.dart';

/// A base [IProxy] implementation.
///
/// [IProxy] implementors:
/// - Provide a method returning the proxy's name.
/// - Provide methods for getting and setting a Data Object.
///
/// Typically, [IProxy]s:
/// - Manipulate the Data Object with type references.
/// - Generate [INotification]s on Data Object changes.
/// - Expose a static final [NAME] string.
/// - Encapsulate interaction with services for data persistence.
///
/// See [IModel].
class Proxy extends Notifier implements IProxy {

  static const NAME = "Proxy";

  final String _name;

  dynamic _data;

  /// Constructor.
  ///
  /// @param [name] The name this [IProxy] will be registered with.
  /// @param [data] The Data Object (optional).
  Proxy([String? name, this._data]) : _name = name ??= NAME;

  /// Called by the [IModel] when the [IProxy] is registered.
  @override
  void onRegister() {}

  /// Called by the [IModel] when the [IProxy] is removed
  @override
  void onRemove() {}

  /// This [IMediator]'s [name].
  @override
  String get name => _name;

  /// This [IProxy]'s [dataObject].
  @override
  dynamic get data => _data;
  @override
  set data(dynamic value) => _data = value;

}
