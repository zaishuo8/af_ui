import 'package:af_ui/af_ui.dart';
import 'package:flutter/widgets.dart';

/// 按钮类型
enum AfButtonType {
  Primary,   // 主色底
  Default,   // 白底 主色边框
  Ghost,     // 透明背景 黑色边框
}
/// 按钮尺寸
enum AfButtonSize {
  Large,  // 默认
  Middle,
  // Small,
}

class _Size {
  final double width;
  final double height;
  final double fontSize;
  final double paddingHorizontal;
  _Size(this.width, this.height, this.fontSize, this.paddingHorizontal);
}
class _Color {
  final Color background;
  final Color text;
  final Color border;
  _Color({this.background, this.text, this.border});
}
class AfButton extends StatelessWidget {

  /// 大按钮高度 字号
  static const HeightLarge = 44.0;
  /// 中按钮高度 字号
  static const HeightMiddle = 32.0;
  /// 圆角
  static const ButtonRadius = 4.0;
  /// 边宽
  static const BorderWidth = 1.0;

  /// 按钮内文字
  final String text;
  /// 点击事件
  final VoidCallback onPressed;
  /// 按钮类型，默认 Default
  final AfButtonType type;
  /// 禁用
  final bool disabled;
  /// 尺寸，默认大；大按钮宽度撑满父容器，中按钮宽度适应内容，暂无小按钮
  final AfButtonSize size;

  const AfButton({
    Key key,
    @required this.text,
    this.onPressed,
    this.type = AfButtonType.Default,
    this.disabled = false,
    this.size = AfButtonSize.Large,
  }) : super(key: key);

  /// 尺寸
  _Size _getSize() {
    switch (size) {
      case AfButtonSize.Large:
        return _Size(double.infinity, HeightLarge, AfFont.Size4, 0);
      case AfButtonSize.Middle:
        /// todo 这里不知道怎么自适应，先用文字数量计算一下宽度，先不用 padding
        return _Size(
            text.length * AfFont.Size5 + 2 * AfLayout.BoxPaddingS,
            // null,
            HeightMiddle,
            AfFont.Size5,
            AfLayout.BoxPaddingS
        );
      default:
        return _Size(double.infinity, HeightLarge, AfFont.Size4, 0);
    }
  }

  /// 颜色（背景、边框、文字）
  _Color _getColor() {
    switch (type) {
      case AfButtonType.Primary:
        return _Color(
          background: AfColor.Primary,
          text: AfColor.White,
          border: AfColor.Primary,
        );
      case AfButtonType.Default:
        return _Color(
          background: AfColor.White,
          text: AfColor.Primary,
          border: AfColor.Primary,
        );
      case AfButtonType.Ghost:
        return _Color(
          background: AfColor.Transparent,
          text: AfColor.Black1,
          border: AfColor.Black4,
        );
      default:
        return _Color(
          background: AfColor.Primary,
          text: AfColor.White,
          border: AfColor.Primary,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (disabled) {
      return AfDisable(child: buildContent(context));
    }
    if (type == AfButtonType.Default) {
      return AfTouchableHighlight(
        child: buildContent(context),
        onPressed: () { if (onPressed != null) onPressed(); },
      );
    } else {
      return AfTouchableOpacity(
        child: buildContent(context),
        onPressed: () { if (onPressed != null) onPressed(); },
      );
    }
  }

  Widget buildContent(BuildContext context) {
    final _size = _getSize();
    final _color = _getColor();
    return Container(
      width: _size.width,
      height: _size.height,
      // todo 中按钮的宽度用文字计算得出了，先不用 padding
      // padding: EdgeInsets.symmetric(horizontal: _size.paddingHorizontal),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ButtonRadius),
        color: _color.background,
        border: Border.all(
          color: _color.border,
          width: BorderWidth,
        )
      ),
      child: Center(
        child: Text(text, style: AfFont.defaultStyle.copyWith(
          color: _color.text,
          fontSize: _size.fontSize,
        )),
      ),
    );
  }
}
