import 'package:flutter/painting.dart';

class AfColor {
  /// 纯白
  static const White = Color(0xFFFFFFFF);
  /// 纯黑
  static const Black = Color(0xFF000000);
  /// 透明色
  static const Transparent = Color(0x00FFFFFF);

  /// 主题色
  static const Primary = Color(0xFFEE0A24);

  /// 不同程度的黑色
  static const Black1 = Color(0xFF0F1826); // 标题、一级信息
  static const Black2 = Color(0xFF6E7580); // 次级文字信息
  static const Black3 = Color(0xFFA9AFB8); // 辅助文字信息
  static const Black4 = Color(0xFFC9CED6); // 预设文字信息
  static const Black5 = Color(0xFFEBEDF0); // 分隔线颜色
  static const Black6 = Color(0xFFF7F8FA); // 页面背景颜色

  /// 功能色
  static const FF576B95 = Color(0xFF576B95); // 文字链颜色
  static const FF07C160 = Color(0xFF07C160); // 成功色
  static const FFEE0A24 = Color(0xFFEE0A24); // 报错色
  static const FFED6A0C = Color(0xFFED6A0C); // 通知消息中的文本颜色
  static const FFFFFBE8 = Color(0xFFFFFBE8); // 通知消息中的背景颜色
  static const FFFAAB0C = Color(0xFFFAAB0C); // 文字辅助颜色

  /// 点击效果覆盖色
  // ignore: non_constant_identifier_names
  static final PressedOpacity = Black.withOpacity(0.2); // 变暗：遮罩 20% 的黑色
  // ignore: non_constant_identifier_names
  static final PressedHighlight = Primary.withOpacity(0.1); // 变亮：遮罩 10% 的主题色
  /// 禁用效果覆盖色
  // ignore: non_constant_identifier_names
  static final Disable = White.withOpacity(0.7); // 遮罩 70% 的白色
}

class AfLayout {
  /// 各类间距
  static const PagePaddingHorizontal = 16.0; // 页面内容左右边距
  static const ModuleMarginVertical = 12.0;  // 卡片、列表、模块上下间距
  static const BoxPaddingL = 16.0; // 内容区域与BOX间距，只有文字内容情况
  static const BoxPaddingS = 12.0; // 内容区域与BOX间距，文字 + 图片/图标等内容

  /// 内容元素间距
  static const ElementMargin0 = 2.0;
  static const ElementMargin1 = 4.0;
  static const ElementMargin2 = 8.0;
  static const ElementMargin3 = 16.0;
  static const ElementMargin4 = 24.0;
  static const ElementMargin5 = 36.0;
  static const ElementMargin6 = 48.0;
}

class AfFont {
  /// 字体
  static const FamilyNotoSans = 'NotoSans';

  /// 字号
  static const Size1 = 32.0;
  static const Size2 = 22.0;
  static const Size3 = 18.0;
  static const Size4 = 16.0;
  static const Size5 = 14.0;
  static const Size6 = 12.0;
  static const Size7 = 10.0;
  /// 行高 height 当用来Text控件上时（会乘以fontSize,所以不以设置过大）
  static const LineHeightRadio = 1.5;

  /// 默认的字体样式
  static const defaultStyle = TextStyle(
    fontFamily: FamilyNotoSans,
    height: LineHeightRadio,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
  );
}
