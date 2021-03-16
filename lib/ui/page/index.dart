import 'package:flutter/widgets.dart';
import 'package:af_ui/af_ui.dart';

class AfPage extends StatelessWidget {

  /// 导航栏，默认是空
  final AfNav nav;

  /// 异常页面
  final AfFault fault;

  /// 骨架屏类型，首次加载数据的时候显示；null 的时候不显示
  final AfSkeleton skeleton;

  /// 展示优先级：skeleton > fault

  /// 页面内容
  /// body 的父容器：
  ///   默认背景色
  ///   撑满屏幕剩余部分，存在 nav 和 tabbar 时，不会撑到这部分内容
  ///   异常页面展示
  final Widget body;

  const AfPage({Key key, this.nav, this.fault, this.skeleton, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: AfColor.Black6,
        child: Column(
          children: [
            nav ?? Container(),
            Expanded(flex: 1, child: skeleton ?? fault ?? body ?? Container()),
          ],
        ),
      ),
    );
  }
}

/// 骨架屏类型；暂时先分 list 和 detail 两个大类型；后期可配置拼接复杂类型
enum _AfSkeletonType {
  List,
  Detail,
}
/// 骨架屏
class AfSkeleton extends StatelessWidget {

  /// 骨架屏分类
  final _AfSkeletonType type;

  AfSkeleton(this.type);
  
  factory AfSkeleton.list() => AfSkeleton(_AfSkeletonType.List);
  
  factory AfSkeleton.detail() => AfSkeleton(_AfSkeletonType.Detail);

  @override
  Widget build(BuildContext context) {
    switch(type) {
      case _AfSkeletonType.List:
        return buildList(context);
      case _AfSkeletonType.Detail:
        return Container(
          color: AfColor.White,
          padding: EdgeInsets.all(AfLayout.BoxPaddingS),
          child: Row(
            children: [
              // 图片区域
              Container(
                width: 48,
                height: 48,
                color: AfColor.Black6,
              ),
            ],
          ),
        );
      default:
        return Container();
    }
  }
  
  buildList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AfLayout.PagePaddingHorizontal,
      ),
      child: Column(
        children: List.filled(10, 0).map((e) => Container()).toList(),
      ),
    );
  }

}

/// 异常页面，空数据，错误页等等
class AfFault extends StatelessWidget {
  
  /// todo 图片资源属性
  
  /// 文案
  final String description;
  
  /// 通用构造函数
  AfFault(this.description);
  
  /// 默认 空页面 构造函数
  factory AfFault.empty(String description) => AfFault(description ?? '暂无数据');

  /// 默认 错误页面 构造函数
  factory AfFault.error(String description) => AfFault(description ?? '哎呀，出错了');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AfColor.White,
      padding: EdgeInsets.symmetric(horizontal: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 通过 flex 1 : 3 来控制距离顶部 25%
          Expanded(flex: 1, child: Container()),
          Expanded(flex: 3, child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
                color: AfColor.FFFFFBE8,
              ),
              Container(
                margin: EdgeInsets.only(top: 18),
                child: Text(description,
                  style: AfFont.defaultStyle.copyWith(
                    color: AfColor.Black4,
                    fontSize: AfFont.Size5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
