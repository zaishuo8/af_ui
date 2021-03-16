import 'package:flutter/widgets.dart';
import 'package:af_ui/af_ui.dart';

class AfSearchController {
  /// 失焦操作
  VoidCallback blur;
  /// 聚焦操作
  VoidCallback focus;

  void dispose() {
    blur = null;
    focus = null;
  }
}

class AfSearch extends StatefulWidget {

  /// 自定义 controller
  final AfSearchController controller;

  /// 输入框默认值，非受控，只初始化阶段有效
  final String defaultValue;
  /// 输入框的值，受控；当有 value 时，defaultValue 失效
  final String value;
  /// 输入框值变化的回调函数，回传参数是输入框内部值
  final ValueChanged<String> onChanged;
  /// placeholder
  final String placeholder;
  /// 允许清空输入框
  final bool allowClear;
  /// 允许取消
  final bool allowCancel;

  /// 点击取消回调
  final VoidCallback onCancelPressed;
  /// 点击键盘 done 完成 按钮
  final VoidCallback onEditingComplete;

  const AfSearch({
    Key key,
    this.controller,
    this.defaultValue,
    this.value,
    this.onChanged,
    this.placeholder = '搜索',
    this.allowClear = false,
    this.allowCancel = false,
    this.onCancelPressed,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AfSearchState();
}

class _AfSearchState extends State<AfSearch> with WidgetsBindingObserver {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  /// value：表示输入框应该显示的值
  /// 有可能改变 value 的地方
  ///   - initState 初始化
  ///   - _onChanged 输入框变化回调
  ///   - didUpdateWidget 外部 value 变化
  String value;
  /// 修改输入框显示的值
  void _setTextInputValue(String value) {
    if (value != _controller.text) {
      if (value == '' || value == null) {
        /// todo 直接清空进到这里有点问题，这里先单独处理
        _controller.value = TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        );
      } else {
        _controller.value = _controller.value.copyWith(
          text: value,
        );
      }
    }
    if (value != this.value) {
      setState(() {
        this.value = value;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    /// 绑定设备监听
    WidgetsBinding.instance.addObserver(this);
    /// 初始化自定义 controller
    if (widget.controller != null) {
      widget.controller.focus = _focus;
      widget.controller.blur = _blur;
    }
    /// 初始化 value；优先级
    _setTextInputValue(widget.value ?? widget.defaultValue ?? '');
  }

  /// 失焦操作
  void _blur() {
    _focusNode.unfocus();
  }
  /// 聚焦操作
  void _focus() {
    _focusNode.requestFocus();
  }

  /// 应用尺寸改变时回调，例如旋转、键盘弹出、收缩
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(MediaQuery.of(context).viewInsets.bottom == 0){
        /// 键盘收起时
        _focusNode.unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AfColor.White,
      // height: 52,
      padding: EdgeInsets.symmetric(
        horizontal: AfLayout.PagePaddingHorizontal,
        vertical: AfLayout.ElementMargin2,
      ),
      child: Row(
        children: [
          Expanded(child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AfColor.Black6,
            ),
            width: double.infinity,
            height: 36,
            padding: EdgeInsets.symmetric(
              horizontal: AfLayout.PagePaddingHorizontal,
              vertical: (36 - AfFont.Size5 * AfFont.LineHeightRadio) / 2,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(right: AfLayout.BoxPaddingS),
                  child: Icon(AfIcons.search, size: AfFont.Size5, color: AfColor.Black4),
                ),
                Expanded(
                    flex: 1,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Text((value == null || value == '') ? (widget.placeholder ?? '') : '',
                          style: AfFont.defaultStyle.copyWith(
                            color: AfColor.Black4,
                            fontSize: AfFont.Size5,
                          ),
                        ),
                        EditableText(
                            minLines: null,
                            maxLines: null,
                            expands: true, /// 撑满父容器，所以大小就用父容器来限制
                            controller: _controller,
                            focusNode: _focusNode,
                            style: AfFont.defaultStyle.copyWith(
                              color: AfColor.Black1,
                              fontSize: AfFont.Size5,
                            ),
                            cursorColor: AfColor.Primary,
                            backgroundCursorColor: AfColor.FF576B95,
                            onChanged: _onChanged,
                            onEditingComplete: widget.onEditingComplete
                        ),
                      ],
                    )
                ),
                (widget.allowClear && value != null && value != '') ? GestureDetector(
                  onTap: () => _onChanged(''),
                  child: Container(
                    padding: EdgeInsets.only(left: AfLayout.BoxPaddingS),
                    child: Icon(
                      AfIcons.error_circle,
                      size: AfFont.Size5,
                      color: AfColor.Black3,
                    ),
                  ),
                ) : Container(width: 0, height: 0),
              ],
            ),
          ), flex: 1),
          widget.allowCancel ? GestureDetector(
            onTap: () { if (widget.onCancelPressed != null) widget.onCancelPressed(); },
            child: Container(
              padding: EdgeInsets.only(left: AfLayout.BoxPaddingS),
              child: Text('取消', style: AfFont.defaultStyle.copyWith(
                color: AfColor.Black1, fontSize: AfFont.Size4,
              )),
            ),
          ) : Container(width: 0, height: 0),
        ],
      ),
    );
  }

  void _onChanged(String value) {

    /// 如果 widget.value 不为 null，表示受控组件，要强制把显示的值改为原来的值
    /// todo 这里强制改回去，会导致光标问题；先不强制改回去了
    // if (widget.value != null && value != this.value) {
    //   _setTextInputValue(this.value);
    // }

    _setTextInputValue(value);
    if (widget.onChanged != null) widget.onChanged(value);
  }

  /// 每次 widget 更新后，通过 _controller 把 widget.value 更新到输入框显示
  @override
  void didUpdateWidget(AfSearch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != null && widget.value != this.value) {
      _setTextInputValue(widget.value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

/// 一个可点击的搜索展示框
class AfSearchPlaceholder extends StatelessWidget {

  final String value;
  final VoidCallback onPressed;

  const AfSearchPlaceholder({
    Key key,
    this.value = '搜索',
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { if (onPressed != null) onPressed(); },
      child: Container(
        color: AfColor.White,
        height: 52,
        padding: EdgeInsets.symmetric(
          horizontal: AfLayout.PagePaddingHorizontal,
          vertical: AfLayout.ElementMargin2,
        ),
        child: Container(
          width: double.infinity,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AfColor.Black6,
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(AfIcons.search, size: AfFont.Size5, color: AfColor.Black4),
                Container(width: AfLayout.ElementMargin1),
                Text(value, style: AfFont.defaultStyle.copyWith(
                  color: AfColor.Black4,
                  fontSize: AfFont.Size5,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
