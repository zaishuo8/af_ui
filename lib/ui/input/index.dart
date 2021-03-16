import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:af_ui/af_ui.dart';

/// 封装成受控组件 通过 value 来控制内容的变化
/// 实现方式：参考 https://github.com/flutter/flutter/issues/43067
/// 该方式是通过对 TextField 的封装
/// 但是，TextField 属于 material 库；所以使用 TextField 外层必须有 Material 容器，不够独立；该组件库需要独立于 material
/// 通过底层的 EditableText 和 TextInput 来自定义一个 AfTextInput

typedef BeforeSmsPressed = Future<bool> Function();
typedef AfterSmsPressed = void Function();

/// 输入框类型
enum AfInputType {
  Default, // 普通类型
  SmsCode, // 验证码类型
}

class AfTextInputController {
  /// 失焦操作
  VoidCallback blur;
  /// 聚焦操作
  VoidCallback focus;

  void dispose() {
    blur = null;
    focus = null;
  }
}

class AfInput extends StatefulWidget {

  /// 自定义 controller
  final AfTextInputController controller;

  /// 输入框默认值，非受控，只初始化阶段有效
  final String defaultValue;
  /// 输入框的值，受控；当有 value 时，defaultValue 失效
  final String value;
  /// 输入框提示文字
  final String label;
  /// 输入框值变化的回调函数，回传参数是输入框内部值
  final ValueChanged<String> onChanged;
  /// 输入框类型
  final AfInputType type;
  /// placeholder
  final String placeholder;
  /// 允许清空输入框
  final bool allowClear;
  /// 禁用
  final bool disabled;
  /// 键盘类型
  final TextInputType keyboardType;

  /// 点击键盘 done 完成 按钮
  final VoidCallback onEditingComplete;

  /// type 为 SmsCode 的时候，beforeSmsPressed 和 afterSmsPressed 才会生效
  /// beforeSmsPressed return true 后，才会倒计时
  final BeforeSmsPressed beforeSmsPressed;
  /// 开始倒计时后，执行 afterSmsPressed
  final AfterSmsPressed afterSmsPressed;

  const AfInput({
    Key key,
    this.controller,
    this.defaultValue,
    this.value,
    this.label,
    this.onChanged,
    this.type = AfInputType.Default,
    this.placeholder,
    this.allowClear = false,
    this.disabled = false,
    this.keyboardType,
    this.onEditingComplete,
    this.beforeSmsPressed,
    this.afterSmsPressed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InputState();
}

class _InputState extends State<AfInput> with WidgetsBindingObserver {
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
    return AfDisable(
      disabled: widget.disabled,
      child: Container(
        color: AfColor.White,
        height: 48,
        padding: EdgeInsets.symmetric(
          horizontal: AfLayout.PagePaddingHorizontal,
          vertical: AfLayout.BoxPaddingS,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (widget.label != null && widget.label != '') ? Container(
              padding: EdgeInsets.only(right: AfLayout.PagePaddingHorizontal + AfLayout.ElementMargin1),
              child: Text(widget.label, style: AfFont.defaultStyle.copyWith(
                color: AfColor.Black1,
                fontSize: AfFont.Size4,
              )),
            ) : Container(width: 0, height: 0),
            Expanded(
                flex: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Text((value == null || value == '') ? (widget.placeholder ?? '') : '',
                      style: AfFont.defaultStyle.copyWith(
                        color: AfColor.Black4,
                        fontSize: AfFont.Size4,
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
                        fontSize: AfFont.Size4,
                      ),
                      cursorColor: AfColor.Primary,
                      backgroundCursorColor: AfColor.FF576B95,
                      onChanged: _onChanged,
                      readOnly: widget.disabled,
                      keyboardType: widget.type == AfInputType.SmsCode ? TextInputType.number : widget.keyboardType,
                      onEditingComplete: widget.onEditingComplete
                    ),
                  ],
                )
            ),
            widget.allowClear ? GestureDetector(
              onTap: () => _onChanged(''),
              child: Container(
                padding: EdgeInsets.only(left: AfLayout.BoxPaddingS),
                child: Icon(
                  AfIcons.error_circle,
                  size: AfFont.Size4, 
                  color: AfColor.Black3,
                ),
              ),
            ) : Container(width: 0, height: 0),
            widget.type == AfInputType.SmsCode ? SmsButton(
              beforeSmsPressed: widget.beforeSmsPressed,
              afterSmsPressed: widget.afterSmsPressed,
            ) : Container(width: 0, height: 0),
          ],
        ),
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
  void didUpdateWidget(AfInput oldWidget) {
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

  /*@override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          // color: AfColor.Split,
          width: 0.5,
        )),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              keyboardType: widget.keyboardType,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintMaxLines: 1,
                  border: InputBorder.none,
                  suffixIcon: (widget.allowClear == true &&
                          widget.value != null &&
                          widget.value != '')
                      ? IconButton(
                          /// todo 使用自己的 icon
                          icon: Icon(
                            Icons.cancel,
                            // color: AfColor.Disabled,
                            size: 18,
                          ),
                          onPressed: () {
                            _controller.clear();
                            widget.onChanged(_controller.text);
                          },
                        )
                      : null),
            ),
          ),
          Offstage(
            offstage: widget.smsCode != true,
            child: SmsButton(
              beforeSmsPressed: widget.beforeSmsPressed,
              afterSmsPressed: widget.afterSmsPressed,
            ),
          ),
        ],
      ),
    );
  }*/
}

class SmsButton extends StatefulWidget {
  final BeforeSmsPressed beforeSmsPressed;
  final AfterSmsPressed afterSmsPressed;

  const SmsButton({
    Key key,
    this.beforeSmsPressed,
    this.afterSmsPressed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SmsButtonState();
}

class _SmsButtonState extends State<SmsButton> {

  Timer _countingTimer;

  bool _counting = false; // 是否正在倒计时
  int _count = 60; // 倒计时秒数

  /// 开始倒计时，然后执行 afterSmsPressed
  startCounting() {
    setState(() {
      _count = 60;
      _counting = true;
    });
    _countingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _count--;
      });
      if (_count == 0) {
        _counting = false;
        _count = 60;
        clearCountingTimer();
      }
    });
    if (widget.afterSmsPressed != null) {
      widget.afterSmsPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (_counting == true) {
          return;
        }
        if (widget.beforeSmsPressed == null) {
          startCounting();
        } else {
          if (await widget.beforeSmsPressed()) {
            startCounting();
          }
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: AfLayout.BoxPaddingL),
        child: Text(
          getButtonText(),
          style: AfFont.defaultStyle.copyWith(
            color: getButtonColor(),
            fontSize: AfFont.Size4,
          ),
        ),
      ),
    );
  }

  getButtonText() {
    if (_counting) {
      return '(${_count}s)后重新发送';
    }
    return '发送验证码';
  }

  getButtonColor() {
    return _counting ? AfColor.Black4 : AfColor.Primary;
  }

  clearCountingTimer() {
    if (_countingTimer != null) {
      _countingTimer.cancel();
    }
  }

  @override
  void dispose() {
    clearCountingTimer();
    super.dispose();
  }
}
