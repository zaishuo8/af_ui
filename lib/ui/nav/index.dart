import 'package:flutter/widgets.dart';
import 'package:af_ui/af_ui.dart';

typedef OnBackPressed = void Function(BuildContext pageContext);

/// 通用导航栏
class AfNav extends StatelessWidget {

  /// 通过静态方法统一配置返回按钮事件
  static OnBackPressed onBackPressed;

  /// 页面的 context
  final BuildContext pageContext;

  /// 中间标题文字
  final String title;

  /// 左侧内容，默认后退箭头
  final Widget leading;
  /// 隐藏箭头
  final bool hideLeading;

  /// 右侧内容，默认 null
  final Widget trailing;

  /// 背景色，默认白色
  final Color backgroundColor;

  const AfNav({
    Key key,
    @required this.title,
    this.leading,
    this.hideLeading,
    this.trailing,
    this.backgroundColor,
    @required this.pageContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: backgroundColor ?? AfColor.White,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildLeft(context),
          buildMiddle(context),
          buildRight(context),
        ],
      ),
    );
  }

  Widget buildLeft(BuildContext context) {
    return Expanded(
      flex: 3,
      child: leading ?? Offstage(offstage: hideLeading == true, child: GestureDetector(
        onTap: () { if (onBackPressed != null) onBackPressed(pageContext); },
        child: Container(
          height: double.infinity,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: AfLayout.PagePaddingHorizontal),
          /// todo 加了颜色，可点击区域就是整个左边；不加颜色，可点击区域只有 icon 部分?
          color: AfColor.White,
          child: Icon(AfIcons.arrow_left,
            color: AfColor.Black2,
            size: 24,
          ),
        ),
      )),
    );
  }

  Widget buildMiddle(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Text(title,
        textAlign: TextAlign.center,
        style: AfFont.defaultStyle.copyWith(
          color: AfColor.Black1,
          fontSize: AfFont.Size3,
        ),
      ),
    );
  }

  Widget buildRight(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        alignment: Alignment.centerRight,
        child: trailing ?? Container(width: 0, height: 0),
      ),
    );
  }

}