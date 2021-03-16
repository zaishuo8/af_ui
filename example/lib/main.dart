import 'package:af_ui/af_ui.dart';
import 'package:flutter/material.dart';

import 'src/button/button.dart';
import 'src/input/input.dart';
import 'src/list/list.dart';

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
      },
    );
  }

}
