import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility_temp_fork/flutter_keyboard_visibility_temp_fork.dart';

import 'package:fusheng/pages/creater/widgets/bottom_panel_content.dart';

enum BottomPanelState { close, panel, keybord }

class BottomPanel extends StatefulWidget {
  final FocusNode focusNode;
  const BottomPanel({super.key, required this.focusNode});

  @override
  State<BottomPanel> createState() => _CreaterBottomPanelState();
}

class _CreaterBottomPanelState extends State<BottomPanel>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  BottomPanelState _panelState = BottomPanelState.close;
  bool _isSwitchingPanel = false;
  late StreamSubscription<bool> keyboardSubscription;

  double _maxHeight = 300; // 键盘高度
  final Duration _duration = Duration(milliseconds: 200);
  final Curve _curve = Curves.fastOutSlowIn;

  final keyboardVisibilityController = KeyboardVisibilityController();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: _duration);

    keyboardSubscription = keyboardVisibilityController.onChange.listen((
      bool visible,
    ) {
      if (!visible && _isSwitchingPanel) {
        _isSwitchingPanel = false;
        return;
      } // 点击按钮手动切换到 panel 时，不监听键盘状态
      _switchState(visible ? BottomPanelState.keybord : BottomPanelState.close);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  // 监听键盘状态
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final bottomInset =
          View.of(context).viewInsets.bottom /
          View.of(context).devicePixelRatio;

      if (_panelState == BottomPanelState.keybord &&
          keyboardVisibilityController.isVisible) {
        if (bottomInset > 0) {
          _maxHeight = bottomInset;
          _controller.value = 1.0;
        } else {
          // inset 归零说明原生收起动画已经跟上了，收尾对齐一次，避免累计误差
          _switchState(BottomPanelState.close);
        }
      }

      print(bottomInset);
    });
  }

  // 状态机
  void _switchState(BottomPanelState target) {
    if (_panelState == target) return;
    if (_panelState == BottomPanelState.keybord &&
        target == BottomPanelState.panel) {
      _isSwitchingPanel = true;
    } else {
      _isSwitchingPanel = false;
    }
    setState(() => _panelState = target);
    switch (target) {
      case BottomPanelState.close:
        print('[STTIFO] close');
        widget.focusNode.unfocus();
        _controller.animateTo(
          0,
          curve: _curve,
          duration: _duration * _controller.value,
        );
        break;
      case BottomPanelState.panel:
        print('[STTIFO] panel');
        widget.focusNode.unfocus();
        _controller.animateTo(
          1,
          curve: _curve,
          duration: _duration * (1 - _controller.value),
        );
        break;
      case BottomPanelState.keybord:
        print('[STTIFO] keyboard');
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

    _controller.animateTo(
      targetProgress,
      curve: _curve,
      duration: _duration * (targetProgress - _controller.value).abs(),
    );

    _switchState(
      targetProgress == 1 ? BottomPanelState.panel : BottomPanelState.close,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListenableBuilder(
          listenable: _controller,
          builder: (context, child) {
            final EdgeInsets safePadding = MediaQuery.paddingOf(context);
            return Container(
              decoration: BoxDecoration(
                border: BoxBorder.fromLTRB(
                  top: BorderSide(
                    width: 2,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  bottom: BorderSide(
                    width: 1,
                    color: Theme.of(context).colorScheme.outlineVariant
                        .withAlpha((255 * _controller.value).toInt()),
                  ),
                ),
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
                              _switchState(BottomPanelState.keybord);
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
          child: BottomPanelContent(),
          builder: (BuildContext context, child) {
            double currentHeight = _controller.value * _maxHeight;

            return SizedBox(
              height: currentHeight,
              child: ClipRect(child: child),
            );
          },
        ),
      ],
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
