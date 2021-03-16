import 'package:flutter/widgets.dart';
import 'package:af_ui/af_ui.dart';

class ListExample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AfPage(
      nav: AfNav(title: 'AF-UI 组件库示例', pageContext: context, hideLeading: true),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: AfLayout.ModuleMarginVertical),
          child: AfList(
            children: <Widget>[
              AfListGroup(
                children: [
                  AfListItem(
                    title: '按钮',
                    description: '跳转按钮示例页',
                    onPressed: () { Navigator.pushNamed(context, '/button'); },
                  ),
                  AfListItem(
                    title: 'Icons',
                    description: 'todo',
                  ),
                ],
              ),
              AfListGroup(
                children: [
                  AfListItem(
                    title: '输入框',
                    onPressed: () { Navigator.pushNamed(context, '/input'); },
                  ),
                ],
              ),
              AfListGroup(
                children: [
                  AfListItem(
                    title: '列表',
                    description: 'todo',
                  ),
                ],
              ),
              AfListGroup(
                children: [
                  AfListItem(
                    title: 'Toast',
                    onPressed: () {},
                  ),
                  AfListItem(
                    title: 'Loading',
                    onPressed: () {
                      // AfUi.showLoading(text: '加载中...' );
                      // Future.delayed(Duration(seconds: 4), () {
                      //   AfUi.hideLoading();
                      // });
                    },
                  ),
                  AfListItem(
                    title: 'Modal',
                    onPressed: () async {
                      // String result = await AfUi.showModal('更新提醒', '修复了几个问题，提升了用户体验');
                      // if (result == 'OnConfirmClick') {
                      //   AfUi.showToast('点击了确认');
                      // }
                      // if (result == 'OnCancelClick') {
                      //   AfUi.showToast('点击了取消');
                      // }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}