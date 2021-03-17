import 'package:flutter/material.dart';
import 'package:af_ui/af_ui.dart';

import 'src/button/button.dart';
import 'src/disable/disable.dart';
import 'src/input/input.dart';
import 'src/list/list.dart';
import 'src/icon/icon.dart';
import 'src/nav/nav.dart';
import 'src/page/page.dart';
import 'src/search/search.dart';
import 'src/tab_nav/search.dart';
import 'src/touchable/touchable.dart';

void main() {
  runApp(ExampleApp());

  AfNav.onBackPressed = (BuildContext pageContext) {
    Navigator.pop(pageContext);
  };
}

class ExampleApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AF-UI 组件库示例',
      initialRoute: '/list',
      routes: {
        '/list': (context) => ListExample(),
        '/button': (context) => ButtonExample(),
        '/input': (context) => InputExample(),
        '/icon': (context) => IconExample(),
        '/search_placeholder': (context) => SearchPlaceholderExample(),
        '/search': (context) => SearchExample(),
        '/tab_nav': (context) => TabNavExample(),
        '/disable': (context) => DisableExample(),
        '/touchable': (context) => TouchableExample(),
        '/nav': (context) => NavExample(),
        '/page_controller': (context) => PageControllerExample(),
        '/page': (context) => PageExample(),
        '/page_fault_error': (context) => PageFaultErrorExample(),
        '/page_fault_empty': (context) => PageFaultEmptyExample(),
        '/page_skeleton': (context) => PageSkeletonExample(),
      },
    );
  }

}
