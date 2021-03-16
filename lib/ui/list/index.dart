import 'package:flutter/widgets.dart';
import 'package:af_ui/af_ui.dart';

class AfList extends StatelessWidget {

  /// todo list 的类型如何限制只能是 AfListGroup 或者 AfListItem
  final List<Widget> children;

  const AfList({
    Key key,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children
    );
  }

}

/// 增加一个分组的概念，todo 配置标题 title
/// 中间有分割线，默认有下外边距 12
class AfListGroup extends StatelessWidget {

  final List<AfListItem> children;

  const AfListGroup({
    Key key,
    @required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AfColor.Black6,
      margin: EdgeInsets.only(bottom: AfLayout.ModuleMarginVertical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children.asMap().map((index, value) => MapEntry(index, Column(
          children: [
            value,
            Offstage(offstage: index == children.length - 1, child: Row(
              children: [
                Container(height: 0.5, color: AfColor.White, width: AfLayout.PagePaddingHorizontal),
                Expanded(flex: 1, child: Container(color: AfColor.Black5, height: 0.5)),
              ],
            ))
          ],
        ))).values.toList(),
      ),
    );
  }

}

class AfListItem extends StatelessWidget {

  /// 左侧 icon 名字，一般左侧 icon 的大小和颜色固定，所以只需要传 icondata 就可以了；当需要自定义的时候，可以使用 leading 参数
  final IconData iconData;
  /// 左侧自定义内容，当 leading 不为空时，忽略 iconName
  final Widget leading;
  /// 标题
  final String title;
  /// 说明文字
  final String description;
  /// 右侧内容，不包括 可点击右箭头（可点击右箭头通过是否可点击 - onPressed 是否为空来判断是否展示）
  final Widget trailing;
  /// 点击回调
  final VoidCallback onPressed;

  const AfListItem({
    Key key,
    this.iconData,
    this.leading,
    this.title,
    this.description,
    this.trailing,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AfTouchableOpacity(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        color: AfColor.White,
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: AfLayout.PagePaddingHorizontal),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildLeft(context),
            buildRight(context),
          ],
        ),
      ),
    );
  }

  Widget buildLeft(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildLeading(context),
        Text(title, style: AfFont.defaultStyle.copyWith(
          color: AfColor.Black1,
          fontSize: AfFont.Size4,
        ))
      ],
    );
  }
  Widget buildLeading(BuildContext context) {
    if (leading != null) {
      return Container(
        margin: EdgeInsets.only(right: AfLayout.BoxPaddingS),
        child: leading,
      );
    }
    if (iconData != null) {
      return Container(
        margin: EdgeInsets.only(right: AfLayout.BoxPaddingS),
        child: Icon(iconData, size: AfFont.Size2, color: AfColor.Black2),
      );
    }
    return Container();
  }

  Widget buildRight(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /// 描述文字
        Text(description ?? '', style: AfFont.defaultStyle.copyWith(
          color: AfColor.Black4,
          fontSize: AfFont.Size5,
        )),
        /// trailing
        trailing == null ? Container() : Container(
          margin: EdgeInsets.only(left: AfLayout.BoxPaddingS),
          child: trailing,
        ),
        /// 可点击 右箭头
        onPressed == null ? Container() : Container(
          margin: EdgeInsets.only(left: AfLayout.BoxPaddingS),
          child: Icon(AfIcons.right, size: AfFont.Size4, color: AfColor.Black3),
        ),
      ],
    );
  }

}