// import 'package:af_ui/af_ui.dart';
// import 'package:flutter/material.dart';
//
// import 'package:af_ui/config/style.dart';
//
// class InputExample extends StatefulWidget {
//
//   @override
//   State<StatefulWidget> createState() => _InputExampleState();
//
// }
//
// class _InputExampleState extends State<InputExample> {
//
//   String text = '';
//   onInputChanged(value) {
//     setState(() {
//       text = value;
//     });
//   }
//
//   String phone = '';
//   onPhoneInputChanged(value) {
//     setState(() {
//       phone = value;
//     });
//   }
//
//   String smsCode = '';
//   onSmsCodeInputChanged(value) {
//     setState(() {
//       smsCode = value;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: AfColor.White,
//       appBar: AfAppBar('输入框示例', onBackPressed: () { Navigator.pop(context); }),
//       body: Container(
//         padding: EdgeInsets.only(top: 10),
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             children: <Widget>[
//               AfInput(
//                 value: text,
//                 onChanged: onInputChanged,
//                 hintText: '请输入内容',
//               ),
//               Container(height: 6),
//               AfInput(
//                 value: phone,
//                 onChanged: onPhoneInputChanged,
//                 hintText: '请输入手机号码',
//                 keyboardType: TextInputType.number,
//                 allowClear: true,
//               ),
//               Container(height: 6),
//               AfInput(
//                 value: smsCode,
//                 onChanged: onSmsCodeInputChanged,
//                 hintText: '请输入验证码',
//                 keyboardType: TextInputType.number,
//                 allowClear: true,
//                 smsCode: true,
//                 beforeSmsPressed: () async {
//                   print('--- beforeSmsPressed ---');
//                   return true;
//                 },
//                 afterSmsPressed: () {
//                   print('--- afterSmsPressed ---');
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }

import 'dart:math';

import 'package:af_ui/af_ui.dart';
import 'package:flutter/widgets.dart';

class InputExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InputExampleState();
}

class _InputExampleState extends State<InputExample> {

  final AfTextInputController afTextInputController = AfTextInputController();

  /// state
  String value1 = '';
  String placeholder = '请输入验证码';

  @override
  Widget build(BuildContext context) {
    return AfPage(
        nav: AfNav(title: '输入框示例', pageContext: context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(height: AfLayout.ModuleMarginVertical),
              AfInput(
                placeholder: '非受控组件',
                defaultValue: '默认值',
              ),
              Container(height: AfLayout.ModuleMarginVertical),
              AfInput(
                placeholder: '受控组件',
                value: value1,
                onChanged: (value) { setState(() { value1 = value; }); },
              ),
              Container(height: AfLayout.ModuleMarginVertical),
              AfInput(
                placeholder: '请输入姓名',
                label: '说明内容',
              ),
              Container(height: AfLayout.ModuleMarginVertical),
              AfInput(
                defaultValue: '禁用',
                disabled: true,
              ),
              Container(height: AfLayout.ModuleMarginVertical),
              AfInput(
                placeholder: '请输入文字',
                defaultValue: '一键清除',
                allowClear: true,
              ),
              Container(height: AfLayout.ModuleMarginVertical),
              AfInput(
                placeholder: placeholder,
                type: AfInputType.SmsCode,
                beforeSmsPressed: () async {
                  if (Random().nextInt(10) > 5) {
                    setState(() {
                      placeholder = '验证码发送成功';
                    });
                    return true;
                  } else {
                    setState(() {
                      placeholder = '验证码发送失败，重试';
                    });
                    return false;
                  }
                },
              ),
              Container(height: AfLayout.ModuleMarginVertical * 4),
              AfInput(
                placeholder: '手动控制焦点',
                controller: afTextInputController,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AfLayout.PagePaddingHorizontal,
                    vertical: AfLayout.ModuleMarginVertical
                ),
                child: Row(
                  children: [
                    AfButton(
                      text: '聚焦',
                      size: AfButtonSize.Middle,
                      type: AfButtonType.Primary,
                      onPressed: () {
                        afTextInputController.focus();
                      },
                    ),
                    Container(width: AfLayout.PagePaddingHorizontal),
                    AfButton(
                      text: '失焦',
                      size: AfButtonSize.Middle,
                      onPressed: () {
                        afTextInputController.blur();
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        )
    );
  }
}

