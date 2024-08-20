import 'package:puremvc/puremvc.dart';

class MacroCommand extends Notifier implements ICommand {
  List<ICommand Function()> subCommands;

  MacroCommand() : subCommands = <ICommand Function()>[] {
    initializeMacroCommand();
  }

  void initializeMacroCommand() {}

  void addSubCommand(ICommand Function() factory) {
    subCommands.add(factory);
  }

  @override
  void execute(INotification notification) {
    while (subCommands.isNotEmpty) {
      final factory = subCommands.removeAt(0);
      ICommand command = factory();
      command.initializeNotifier(multitonKey);
      command.execute(notification);
    }
  }
}
