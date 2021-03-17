import 'package:flutter/widgets.dart';
import 'package:af_ui/af_ui.dart';

class TabNavExample extends StatelessWidget {

  final AfTabNavController controller = AfTabNavController();

  @override
  Widget build(BuildContext context) {

    return AfPage(
      body: AfTabNav(
        controller: controller,
        titleList: ['发现', '我家', '消息', '我的'],
        iconDataList: [
          AfIcons.after_sales,
          AfIcons.customer_service,
          AfIcons.message,
          AfIcons.info_circle,
        ],
        screens: [
          AfPage(nav: AfNav(title: '发现', hideLeading: true)),
          AfPage(nav: AfNav(title: '我家', hideLeading: true)),
          AfPage(nav: AfNav(title: '消息', hideLeading: true)),
          AfPage(nav: AfNav(title: '我的', hideLeading: true), body: Container(
            margin: EdgeInsets.symmetric(
              horizontal: AfLayout.PagePaddingHorizontal,
              vertical: AfLayout.ModuleMarginVertical,
            ),
            child: Column(
              children: [
                AfButton(text: '返回第一页', onPressed: () { controller.changeTab(0); },),
              ],
            ),
          ),),
        ],
      ),
    );
  }

}
