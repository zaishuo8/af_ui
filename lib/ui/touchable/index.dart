import 'package:af_ui/af_ui.dart';
import 'package:flutter/widgets.dart';

/// 通用点击效果，只有在传了点击回调函数时才会展示效果
abstract class _AfTouchable extends StatefulWidget {

  /// 被包裹展示的元素
  final Widget child;

  /// 点击事件
  final VoidCallback onPressed;

  const _AfTouchable({
    Key key,
    this.onPressed,
    @required this.child
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AfTouchableState(_AfTouchType.Opacity);
}

/// 点击变暗：遮罩 20% 的黑色
class AfTouchableOpacity extends _AfTouchable {

  /// 被包裹展示的元素
  final Widget child;

  /// 点击事件
  final VoidCallback onPressed;

  const AfTouchableOpacity({
    Key key,
    this.onPressed,
    @required this.child
  }) : super(key: key, onPressed: onPressed, child: child);

  @override
  State<StatefulWidget> createState() => _AfTouchableState(_AfTouchType.Opacity);
}

/// 点击变亮：遮罩 10% 的主题色
class AfTouchableHighlight extends _AfTouchable {

  /// 被包裹展示的元素
  final Widget child;

  /// 点击事件
  final VoidCallback onPressed;

  const AfTouchableHighlight({
    Key key,
    this.onPressed,
    @required this.child
  }) : super(key: key, onPressed: onPressed, child: child);

  @override
  State<StatefulWidget> createState() => _AfTouchableState(_AfTouchType.Highlight);
}

/// 共用一个 state，区分不同的类型
enum _AfTouchType {
  Opacity,
  Highlight,
}
/// 按下 / 释放 状态
enum _AfTapStatus {
  Down,
  Up,
}
class _AfTouchableState extends State<_AfTouchable> {

  final _AfTouchType type;

  _AfTouchableState(this.type);

  _AfTapStatus _tapStatus = _AfTapStatus.Up;

  @override
  void initState() {
    super.initState();
  }

  Color get tapDownColor {
    switch (type) {
      case _AfTouchType.Opacity:
        return AfColor.PressedOpacity;
      case _AfTouchType.Highlight:
        return AfColor.PressedHighlight;
      default:
        return AfColor.PressedOpacity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (e) {
        if (widget.onPressed != null) {
          setState(() {
            _tapStatus = _AfTapStatus.Down;
          });
        }
      },
      onTapUp: (e) {
        if (widget.onPressed != null) {
          setState(() {
            _tapStatus = _AfTapStatus.Up;
          });
        }
      },
      onTapCancel: () {
        if (widget.onPressed != null) {
          setState(() {
            _tapStatus = _AfTapStatus.Up;
          });
        }
      },
      onTap: widget.onPressed,
      child: Stack(
        children: [
          widget.child,
          _tapStatus == _AfTapStatus.Down ? Positioned(
            left: 0, right: 0, top: 0, bottom: 0,
            child: Container(color: tapDownColor),
          ) : Container(width: 0, height: 0),
        ],
      ),
    );
  }
}
