/// flutter sdk
import 'package:flutter/services.dart';

/// af_ui api
import 'package:af_ui/api/loading/loading.dart';
import 'package:af_ui/api/modal/modal.dart';
import 'package:af_ui/api/toast/toast.dart';

/// af_ui ui
export 'ui/icon/index.dart';
export 'ui/nav/index.dart';
export 'ui/page/index.dart';
export 'ui/touchable/index.dart';
export 'ui/list/index.dart';
export 'ui/disable/index.dart';
export 'ui/button/index.dart';
export 'ui/input/index.dart';


/// af_ui style
export 'config/style.dart';

class AfUi {
  static const MethodChannel channel = const MethodChannel('af_ui');

  static void showToast(String text) {
    Toast.show(text);
  }

  static void showLoading({String text}) {
    Loading.show(text);
  }

  static void hideLoading() {
    Loading.hide();
  }

  static Future<String> showModal(String title, String content) async {
    return Modal.show(title, content);
  }

  /*
  * 目前点击 modal 的按钮，默认收起 modal
  static void hideModal() {
    Modal.hide();
  }*/
}
