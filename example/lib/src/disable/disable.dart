import 'package:flutter/widgets.dart';
import 'package:af_ui/af_ui.dart';

class DisableExample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AfPage(
      nav: AfNav(title: '禁用示例', pageContext: context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: AfLayout.PagePaddingHorizontal),
        child: Column(
          children: [
            Container(height: AfLayout.ModuleMarginVertical),
            AfDisable(
              child: Container(
                width: double.infinity,
                height: 48,
                color: AfColor.FF576B95,
                child: Center(
                  child: Text('禁用状态样式', style: AfFont.defaultStyle.copyWith(
                    fontSize: AfFont.Size3,
                    color: AfColor.White,
                  )),
                ),
              ),
            ),
            Container(height: AfLayout.ModuleMarginVertical),
            AfDisable(
              disabled: false,
              child: Container(
                width: double.infinity,
                height: 48,
                color: AfColor.FF576B95,
                child: Center(
                  child: Text('非禁用状态样式', style: AfFont.defaultStyle.copyWith(
                    fontSize: AfFont.Size3,
                    color: AfColor.White,
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
