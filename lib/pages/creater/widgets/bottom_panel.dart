import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_keyboard_visibility_temp_fork/flutter_keyboard_visibility_temp_fork.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'package:fusheng/pages/creater/widgets/bottom_panel_content.dart';

enum BottomPanelState { close, panel, keyboard }

class BottomPanel extends StatefulWidget {
  final FocusNode focusNode;
  final QuillController quillController;
  const BottomPanel({
    super.key,
    required this.focusNode,
    required this.quillController,
  });

  @override
  State<BottomPanel> createState() => _CreaterBottomPanelState();
}

class _CreaterBottomPanelState extends State<BottomPanel>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  BottomPanelState _panelState = BottomPanelState.close;

  double _maxHeight = 300; // 预设键盘高度
  Timer? _debounceTimer; // 用于测量键盘高度的防抖计时器
  final Duration _duration = Duration(milliseconds: 300);
  final Curve _curve = Curves.easeOutCubic;

  late StreamSubscription<bool> keyboardSubscription;
  late AnimationController _controller;
  bool _isFromKeyboardToPanel = false;

  @override
  void initState() {
    super.initState();

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription = keyboardVisibilityController.onChange.listen((
      bool visible,
    ) {
      // 当从键盘切换到面板时面板不收回
      if (_isFromKeyboardToPanel) {
        _isFromKeyboardToPanel = false;
        return;
      }
      _switchState(
        visible ? BottomPanelState.keyboard : BottomPanelState.close,
      );
    });

    _controller = AnimationController(vsync: this, duration: _duration);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    keyboardSubscription.cancel();
    super.dispose();
  }

  // 监听键盘状态
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final inset = MediaQuery.viewInsetsOf(context).bottom;

      // 只在键盘弹出时监测高度
      if (inset <= 0) return;

      // 取消上一次的防抖计时
      _debounceTimer?.cancel();

      // 设定新的防抖计时，300ms 后认为高度已稳定
      _debounceTimer = Timer(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        // 再次确认当前高度，避免延迟期间值改变
        final stableInset = MediaQuery.viewInsetsOf(context).bottom;
        if (stableInset > 0 && (stableInset - _maxHeight).abs() > 10) {
          setState(() {
            _maxHeight = stableInset;
          });
        }
      });
    });
  }

  // 状态机
  void _switchState(BottomPanelState target) {
    if (_panelState == target) return;
    // 当从键盘切换到面板时，标记以防面板收回
    if (_panelState == BottomPanelState.keyboard &&
        target == BottomPanelState.panel) {
      _isFromKeyboardToPanel = true;
    } else {
      _isFromKeyboardToPanel = false;
    }

    Duration durationToClose = _duration * _controller.value;
    if (_panelState == BottomPanelState.keyboard &&
        target == BottomPanelState.close) {
      // 加快动画速度，以补偿动画延迟
      durationToClose = _duration * 0.3;
    }

    setState(() => _panelState = target);

    switch (target) {
      case BottomPanelState.close:
        widget.focusNode.unfocus();
        _controller.animateTo(0, curve: _curve, duration: durationToClose);
        break;
      case BottomPanelState.panel:
        widget.focusNode.unfocus();
        _controller.animateTo(
          1,
          curve: _curve,
          duration: _duration * (1 - _controller.value),
        );
        break;
      case BottomPanelState.keyboard:
        _controller.animateTo(
          1,
          curve: _curve,
          duration: _duration * (1 - _controller.value),
        );
        widget.focusNode.requestFocus();
        break;
    }
  }

  // 拖拽时
  void _onDragUpdate(DragUpdateDetails details) {
    // details.delta.dy 代表手指在垂直方向上的移动距离
    double deltaProgress = -details.delta.dy / _maxHeight;

    // 通过 controller 应用，并且限制范围
    _controller.value = (_controller.value + deltaProgress).clamp(0.0, 1.0);
  }

  // 松开后
  void _onDragEnd(DragEndDetails details) {
    double speedOnEnd = details.primaryVelocity ?? 0;
    double targetProgress;

    // 先根据松手速度判断明确意图
    if (speedOnEnd < -300) {
      targetProgress = 1;
    } else if (speedOnEnd > 300) {
      targetProgress = 0;
    } else {
      // 否则根据位置判断意图
      targetProgress = _controller.value > 0.5 ? 1.0 : 0.0;
    }

    _switchState(
      targetProgress == 1 ? BottomPanelState.panel : BottomPanelState.close,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // false 时按返回键不会退出当前页面
      canPop: !(_panelState == BottomPanelState.panel),
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        // 如果成功 pop，直接返回
        if (didPop) return;

        // 如果面板打开，返回时收起面板
        if (_panelState == BottomPanelState.panel) {
          _switchState(BottomPanelState.close);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListenableBuilder(
            listenable: _controller,
            builder: (context, child) {
              final EdgeInsets safePadding = MediaQuery.paddingOf(context);
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: safePadding.bottom * (1 - _controller.value),
                  ),
                  child: child,
                ),
              );
            },
            child: GestureDetector(
              onVerticalDragUpdate: _onDragUpdate,
              onVerticalDragEnd: _onDragEnd,
              behavior: HitTestBehavior.opaque,

              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomBarItem(onTap: () {}, icon: Icon(Icons.space_bar)),
                    BottomBarItem(onTap: () {}, icon: Icon(Icons.space_bar)),
                    BottomBarItem(onTap: () {}, icon: Icon(Icons.space_bar)),
                    BottomBarItem(onTap: () {}, icon: Icon(Icons.space_bar)),
                    ListenableBuilder(
                      listenable: _controller,
                      builder: (context, child) =>
                          _panelState == BottomPanelState.panel
                          ? BottomBarItem(
                              onTap: () {
                                _switchState(BottomPanelState.keyboard);
                              },
                              icon: Icon(Icons.keyboard),
                            )
                          : BottomBarItem(
                              onTap: () {
                                _switchState(BottomPanelState.panel);
                              },
                              icon: Icon(Icons.widgets_outlined),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListenableBuilder(
            listenable: _controller,
            child: BottomPanelContent(controller: widget.quillController),
            builder: (BuildContext context, child) {
              double currentHeight = _controller.value * _maxHeight;

              return SizedBox(
                height: currentHeight,
                child: ClipRect(child: child),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  final Icon icon;
  final VoidCallback onTap;
  const BottomBarItem({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        HapticFeedback.successNotification();
        onTap();
      },
      icon: icon,
    );
  }
}
