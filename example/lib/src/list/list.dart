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
                    title: '图标',
                    description: '跳转图标示例页',
                    onPressed: () { Navigator.pushNamed(context, '/icon'); },
                  ),
                  AfListItem(
                    title: '禁用',
                    onPressed: () { Navigator.pushNamed(context, '/disable'); },
                  ),
                  AfListItem(
                    title: '可点击',
                    onPressed: () { Navigator.pushNamed(context, '/touchable'); },
                  ),
                  AfListItem(
                    title: '按钮',
                    onPressed: () { Navigator.pushNamed(context, '/button'); },
                  ),
                ],
              ),
              AfListGroup(
                children: [
                  AfListItem(
                    title: '顶部导航栏',
                    onPressed: () { Navigator.pushNamed(context, '/nav'); },
                  ),
                  AfListItem(
                    title: '底部导航',
                    onPressed: () { Navigator.pushNamed(context, '/tab_nav'); },
                  ),
                  AfListItem(
                    title: '页面容器',
                    onPressed: () { Navigator.pushNamed(context, '/page_controller'); },
                  ),
                ],
              ),
              AfListGroup(
                children: [
                  AfListItem(
                    title: '输入框',
                    onPressed: () { Navigator.pushNamed(context, '/input'); },
                  ),
                  AfListItem(
                    title: '搜索框',
                    onPressed: () { Navigator.pushNamed(context, '/search_placeholder'); },
                  ),
                ],
              ),
              AfListGroup(
                children: [
                  AfListItem(
                    title: '列表',
                    description: '当前页面即为列表示例',
                  ),
                ],
              ),
              AfListGroup(
                children: [
                  AfListItem(
                    title: '轻提示',
                    onPressed: () {},
                  ),
                  AfListItem(
                    title: '加载提示',
                    onPressed: () {
                      // AfUi.showLoading(text: '加载中...' );
                      // Future.delayed(Duration(seconds: 4), () {
                      //   AfUi.hideLoading();
                      // });
                    },
                  ),
                  AfListItem(
                    title: '对话框',
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