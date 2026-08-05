import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:fusheng/i18n/strings.g.dart';

enum QuillAction {
  // Inline
  fontSize,
  bold,
  italic,
  underline,
  strikethrough,
  inlineCode,
  subscript,
  superscript,
  textColor,
  backgroundColor,
  link,

  // Block
  clearFormat,
  heading,
  orderedList,
  unorderedList,
  todoList,
  codeBlock,
  quote,
  indent,
  outdent,
}

class BottomPanelItem extends StatelessWidget {
  final Widget button;
  final String label;

  const BottomPanelItem({super.key, required this.button, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        button,
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}

extension QuillActionX on QuillAction {
  // 触觉反馈包裹器
  Widget _withHaptic(Widget child) {
    return Listener(
      onPointerDown: (_) => HapticFeedback.lightImpact(),
      child: child,
    );
  }

  // 获取 i18n 标签
  String getLabel(BuildContext context) {
    final actions = t.creater.actions;
    return switch (this) {
      QuillAction.fontSize => actions.inline.fontSize,
      QuillAction.bold => actions.inline.bold,
      QuillAction.italic => actions.inline.italic,
      QuillAction.underline => actions.inline.underline,
      QuillAction.strikethrough => actions.inline.strikethrough,
      QuillAction.inlineCode => actions.inline.inlineCode,
      QuillAction.subscript => actions.inline.subscript,
      QuillAction.superscript => actions.inline.superscript,
      QuillAction.textColor => actions.inline.textColor,
      QuillAction.backgroundColor => actions.inline.backgroundColor,
      QuillAction.link => actions.inline.link,
      QuillAction.clearFormat => actions.block.clearFormat,
      QuillAction.heading => actions.block.heading,
      QuillAction.orderedList => actions.block.orderedList,
      QuillAction.unorderedList => actions.block.unorderedList,
      QuillAction.todoList => actions.block.todoList,
      QuillAction.codeBlock => actions.block.codeBlock,
      QuillAction.quote => actions.block.quote,
      QuillAction.indent => actions.block.indent,
      QuillAction.outdent => actions.block.outdent,
    };
  }

  // 不带 label
  Widget buildButton(QuillController controller) {
    final rawButton = switch (this) {
      QuillAction.fontSize => QuillToolbarFontSizeButton(
        controller: controller,
      ),
      QuillAction.bold => QuillToolbarToggleStyleButton(
        controller: controller,
        attribute: Attribute.bold,
      ),
      QuillAction.italic => QuillToolbarToggleStyleButton(
        controller: controller,
        attribute: Attribute.italic,
      ),
      QuillAction.underline => QuillToolbarToggleStyleButton(
        controller: controller,
        attribute: Attribute.underline,
      ),
      QuillAction.strikethrough => QuillToolbarToggleStyleButton(
        controller: controller,
        attribute: Attribute.strikeThrough,
      ),
      QuillAction.inlineCode => QuillToolbarToggleStyleButton(
        controller: controller,
        attribute: Attribute.inlineCode,
      ),
      QuillAction.subscript => QuillToolbarToggleStyleButton(
        controller: controller,
        attribute: Attribute.subscript,
      ),
      QuillAction.superscript => QuillToolbarToggleStyleButton(
        controller: controller,
        attribute: Attribute.superscript,
      ),
      QuillAction.textColor => QuillToolbarColorButton(
        controller: controller,
        isBackground: false,
      ),
      QuillAction.backgroundColor => QuillToolbarColorButton(
        controller: controller,
        isBackground: true,
      ),
      QuillAction.link => QuillToolbarLinkStyleButton(controller: controller),
      QuillAction.clearFormat => QuillToolbarClearFormatButton(
        controller: controller,
      ),
      QuillAction.heading => QuillToolbarSelectHeaderStyleDropdownButton(
        controller: controller,
      ),
      QuillAction.orderedList => QuillToolbarToggleStyleButton(
        controller: controller,
        attribute: Attribute.ol,
      ),
      QuillAction.unorderedList => QuillToolbarToggleStyleButton(
        controller: controller,
        attribute: Attribute.ul,
      ),
      QuillAction.todoList => QuillToolbarToggleCheckListButton(
        controller: controller,
      ),
      QuillAction.codeBlock => QuillToolbarToggleStyleButton(
        controller: controller,
        attribute: Attribute.codeBlock,
      ),
      QuillAction.quote => QuillToolbarToggleStyleButton(
        controller: controller,
        attribute: Attribute.blockQuote,
      ),
      QuillAction.indent => QuillToolbarIndentButton(
        controller: controller,
        isIncrease: true,
      ),
      QuillAction.outdent => QuillToolbarIndentButton(
        controller: controller,
        isIncrease: false,
      ),
    };

    // 震动反馈
    return _withHaptic(rawButton);
  }

  // 带 label
  Widget buildPanelItem(BuildContext context, QuillController controller) {
    return BottomPanelItem(
      button: buildButton(controller),
      label: getLabel(context),
    );
  }
}
