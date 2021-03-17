import 'package:flutter/widgets.dart';
import 'package:af_ui/af_ui.dart';

class NavExample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AfPage(
      body: Container(
        child: Column(
          children: [
            AfNav(title: '普通导航', pageContext: context),
            Container(height: AfLayout.ModuleMarginVertical),
            AfNav(title: '隐藏返回键', pageContext: context, hideLeading: true),
            Container(height: AfLayout.ModuleMarginVertical),
            AfNav(title: '自定义左侧', pageContext: context, leading: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(width: AfLayout.PagePaddingHorizontal),
                Icon(
                  AfIcons.location,
                  color: AfColor.Black1,
                  size: AfFont.Size3,
                ),
                Container(width: AfLayout.ElementMargin1),
                Text('杭州', style: AfFont.defaultStyle.copyWith(
                  color: AfColor.Black1,
                  fontSize: AfFont.Size4,
                ))
              ],
            )),
            Container(height: AfLayout.ModuleMarginVertical),
            AfNav(title: '自定义右侧', pageContext: context, trailing: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  AfIcons.message,
                  color: AfColor.Black1,
                  size: AfFont.Size2,
                ),
                Container(width: AfLayout.PagePaddingHorizontal),
              ],
            )),
          ],
        ),
      ),
    );
  }

}
