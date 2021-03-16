import 'package:af_ui/af_ui.dart';

class Modal {

  /// 因为无法将方法传到原生端，所以通过结果监听点击了哪个按钮 OnCancelClick OnConfirmClick
  static Future<String> show(String title, String content) async {
    Map params = <String, String> {
      'title': title,
      'content': content,
    };
    return await AfUi.channel.invokeMethod('showModal', params);
  }

  /// todo 这里有个很奇怪的 bug；从 flutter 项目启动，调用 invokeMethod('hideModal') 没有把 modal 收起来；
  /// todo 但是从 android 项目启动，就是正常的；所以这里先隐藏 hideModal 接口；直接点击之后默认隐藏
  /* static hide() {
    AfUi.channel.invokeMethod('hideModal');
  }*/

}