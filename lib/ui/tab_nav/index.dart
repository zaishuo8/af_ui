import 'package:af_ui/af_ui.dart';
import 'package:flutter/widgets.dart';

typedef TabChange = void Function(int index);

class AfTabNavController {
  /// 切换 tab
  TabChange changeTab;

  void dispose() {
    changeTab = null;
  }
}

class AfTabNav extends StatefulWidget {

  /// 标题列表
  final List<String> titleList;
  /// icon 列表
  final List<IconData> iconDataList;
  /// 自定义底部 tab；当 tabs 不为空时，上面两个配置项失效
  final List<Widget> tabs;

  /// 页面列表
  final List<Widget> screens;

  /// 默认选中页面索引
  final int defaultActiveIndex;

  /// 页面切换回调，参数：切换后的索引
  final TabChange onTabChanged;

  /// controller
  final AfTabNavController controller;

  const AfTabNav({
    Key key,
    this.titleList,
    this.iconDataList,
    this.tabs,
    this.screens,
    this.defaultActiveIndex,
    this.onTabChanged,
    this.controller,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabNavState();
}

class _TabNavState extends State<AfTabNav> {

  /// 普通成员变量
  /// 已经渲染过的 screen
  final Map<int, Widget> renderedScreens = {};

  /// state 成员变量
  /// 选中项
  int _activeIndex;

  /// 改变选中页
  void _changeActiveTab(int index) {
    setState(() {
      _activeIndex = index;
    });
    if (widget.onTabChanged != null) widget.onTabChanged(index);
  }

  @override
  void initState() {
    super.initState();

    _activeIndex = widget.defaultActiveIndex ?? 0;

    /// controller 赋能
    if (widget.controller != null) {
      widget.controller.changeTab = _changeActiveTab;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildScreens(context),
        buildBottomTabBar(context),
      ],
    );
  }

  Widget buildScreens(BuildContext context) {
    return Expanded(flex: 1, child: Container(
      child: widget.screens[_activeIndex],
    ));
  }

  Widget buildBottomTabBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: 52,
      padding: EdgeInsets.only(top: 7.5, bottom: 2),
      decoration: BoxDecoration(
        color: AfColor.White,
        border: Border(top: BorderSide(
          color: AfColor.Black5,
          width: 0.5,
        )),
      ),
      child: Row(
        children: buildBars(context),
      ),
    );
  }
  List<Widget> buildBars(BuildContext context) {
    if (widget.tabs != null) {
      return widget.tabs.asMap().map((index, tab) => MapEntry(index, Expanded(flex: 1, child: Center(
        child: GestureDetector(
          onTap: () { _changeActiveTab(index); },
          child: tab,
        ),
      )))).values.toList();
    } else {
      return widget.titleList.asMap().map((index, title) => MapEntry(index, Expanded(flex: 1, child: GestureDetector(
        onTap: () { _changeActiveTab(index); },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              widget.iconDataList[index],
              size: 24,
              color: _activeIndex == index ? AfColor.Primary : AfColor.Black4,
            ),
            Text(title, style: AfFont.defaultStyle.copyWith(
              fontSize: AfFont.Size6,
              color: _activeIndex == index ? AfColor.Primary : AfColor.Black4,
            )),
          ],
        ),
      )))).values.toList();
    }
  }
}
