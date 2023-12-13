import 'package:puremvc/puremvc.dart';

abstract class ICommand extends INotifier {
  void execute(INotification notification);
}
