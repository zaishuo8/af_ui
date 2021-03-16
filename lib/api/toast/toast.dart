import 'package:af_ui/af_ui.dart';

class Toast {
  static show(String text) {
    AfUi.channel.invokeMethod('toast', text);
  }
}