// import 'package:flutter/material.dart';
//
// /// todo 标签
// class Tag extends StatefulWidget {
//
//   final String text;
//   final Icon icon; /// todo 用自己的 icon 库
//   final bool selected; /// 选中状态，默认 false
//   final VoidCallback onPressed;
//   final num width; /// 默认宽度被撑开；当设置宽度时，使用宽度
//   final TagShape shape; /// 形状，默认 round
//   final TagSize size; /// 大小，默认 middle
//
//   const Tag({
//     Key key,
//     this.text,
//     this.icon,
//     this.selected,
//     this.onPressed,
//     this.width,
//     this.shape,
//     this.size,
//   }) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _TagState();
// }
//
// class _TagState extends State<Tag> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
//
// }
//
// /// 标签形状
// class TagShape {
//   static const Round = 'round'; // 矩形，带一定小弧度 默认值
//   static const Circle = 'circle'; // 左右圆弧
// }
//
// /// 标签大小
// class TagSize {
//   static const Large = 'large';
//   static const Middle = 'middle';
//   static const Small = 'small';
// }
