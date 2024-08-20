import '../../puremvc.dart';

abstract class IModel {
  void registerProxy(IProxy proxy);

  IProxy? retrieveProxy(String proxyName);

  bool hasProxy(String proxyName);

  IProxy? removeProxy(String proxyName);
}
