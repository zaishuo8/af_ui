import 'package:flutter/widgets.dart';
import 'package:af_ui/af_ui.dart';

class ButtonExample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AfPage(
      nav: AfNav(title: '按钮示例', pageContext: context),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AfLayout.PagePaddingHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(height: AfLayout.ModuleMarginVertical),
              AfButton(text: '主题色按钮', type: AfButtonType.Primary),
              Container(height: AfLayout.ModuleMarginVertical),
              AfButton(text: '主题色禁用按钮', type: AfButtonType.Primary, disabled: true),
              Container(height: AfLayout.ModuleMarginVertical),
              AfButton(text: '默认按钮'),
              Container(height: AfLayout.ModuleMarginVertical),
              AfButton(text: '默认禁用按钮', disabled: true),
              Container(height: AfLayout.ModuleMarginVertical),
              AfButton(text: '幽灵按钮', type: AfButtonType.Ghost),
              Container(height: AfLayout.ModuleMarginVertical),
              AfButton(text: '幽灵禁用按钮', type: AfButtonType.Ghost, disabled: true),
              Container(height: AfLayout.ModuleMarginVertical),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: AfLayout.BoxPaddingS, // 主轴(水平)方向间距
                runSpacing: AfLayout.ModuleMarginVertical, // 纵轴（垂直）方向间距
                children: <Widget>[
                  AfButton(text: '中按钮', type: AfButtonType.Primary, size: AfButtonSize.Middle),
                  AfButton(text: '中按钮禁用', type: AfButtonType.Primary, disabled: true, size: AfButtonSize.Middle),
                  AfButton(text: '默认中按钮', size: AfButtonSize.Middle),
                  AfButton(text: '幽灵中按钮', type: AfButtonType.Ghost, size: AfButtonSize.Middle),
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }

}