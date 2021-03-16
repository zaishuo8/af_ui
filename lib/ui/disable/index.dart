import 'package:flutter/widgets.dart';
import 'package:af_ui/af_ui.dart';

/// 通用 禁用 样式
class AfDisable extends StatelessWidget {

  /// 被包裹展示的元素
  final Widget child;

  /// 是否展示禁用样式
  final bool disabled;

  const AfDisable({
    Key key,
    this.disabled = true,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        disabled ? Positioned(
          left: 0, right: 0, top: 0, bottom: 0,
          child: Container(color: AfColor.Disable),
        ) : Container(),
      ],
    );
  }
}
