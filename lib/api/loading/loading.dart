import 'package:af_ui/af_ui.dart';

class Loading {

  static show(String text) {
    AfUi.channel.invokeMethod('showLoading', text);
  }

  static hide() {
    AfUi.channel.invokeMethod('hideLoading');
  }

}