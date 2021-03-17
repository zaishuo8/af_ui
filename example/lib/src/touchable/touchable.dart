import 'package:flutter/widgets.dart';
import 'package:af_ui/af_ui.dart';

class TouchableExample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AfPage(
      nav: AfNav(title: '点击示例', pageContext: context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: AfLayout.PagePaddingHorizontal),
        child: Column(
          children: [
            Container(height: AfLayout.ModuleMarginVertical),
            AfTouchableHighlight(
              onPressed: () {},
              child: Container(
                width: double.infinity,
                height: 48,
                color: AfColor.FF576B95,
                child: Center(
                  child: Text('点击变亮', style: AfFont.defaultStyle.copyWith(
                    fontSize: AfFont.Size3,
                    color: AfColor.White,
                  )),
                ),
              ),
            ),
            Container(height: AfLayout.ModuleMarginVertical),
            AfTouchableOpacity(
              onPressed: () {},
              child: Container(
                width: double.infinity,
                height: 48,
                color: AfColor.FF576B95,
                child: Center(
                  child: Text('点击变暗', style: AfFont.defaultStyle.copyWith(
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
