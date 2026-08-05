import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class AdaptiveCheckboxBuilder implements QuillCheckboxBuilder {
  const AdaptiveCheckboxBuilder();

  @override
  Widget build({
    required BuildContext context,
    required bool isChecked,
    required ValueChanged<bool> onChanged,
  }) {
    final textStyle = DefaultTextStyle.of(context).style;
    final fontSize = textStyle.fontSize ?? 14.0;
    // 估算行高（通常 fontSize * 1.2 ~ 1.5，具体看字体）
    final lineHeight = fontSize * 1.4;
    final size = lineHeight.clamp(16.0, 32.0); // 限制范围，避免过大或过小

    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: Checkbox(
          value: isChecked,
          onChanged: (newValue) {
            if (newValue != null) onChanged(newValue);
          },
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}

class OptimizedEditor extends StatelessWidget {
  const OptimizedEditor({
    super.key,
    required this._controller,
    required this._focusNode,
  });

  final QuillController _controller;
  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: QuillEditor.basic(
          controller: _controller,
          config: QuillEditorConfig(
            customStyles: DefaultStyles(
              h1: DefaultTextBlockStyle(
                TextStyle(
                  fontFamily: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 30,
                  // height: 1.4,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight(700),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const HorizontalSpacing(0, 0),
                const VerticalSpacing(6, 6),
                const VerticalSpacing(0, 0),
                null,
              ),
              h2: DefaultTextBlockStyle(
                TextStyle(
                  fontFamily: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 27,
                  // height: 1.4,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight(700),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const HorizontalSpacing(0, 0),
                const VerticalSpacing(6, 6),
                const VerticalSpacing(0, 0),
                null,
              ),
              h3: DefaultTextBlockStyle(
                TextStyle(
                  fontFamily: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 24,
                  // height: 1.4,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight(700),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const HorizontalSpacing(0, 0),
                const VerticalSpacing(6, 6),
                const VerticalSpacing(0, 0),
                null,
              ),
              paragraph: DefaultTextBlockStyle(
                TextStyle(
                  fontFamily: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 16,
                  height: 1.7,
                  letterSpacing: 0.9,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const HorizontalSpacing(0, 0),
                const VerticalSpacing(5, 5),
                const VerticalSpacing(0, 0),
                null,
              ),
              underline: TextStyle(
                decoration: TextDecoration.underline,
                decorationThickness: 2,
              ),
              strikeThrough: TextStyle(
                decoration: TextDecoration.lineThrough,
                decorationThickness: 2,
              ),
              inlineCode: InlineCodeStyle(
                style: TextStyle(fontSize: 14, fontFamily: 'monospace'),
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer,
                radius: Radius.circular(4),
              ),
              link: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                decorationColor: Theme.of(context).colorScheme.primary,
              ),
              lists: DefaultListBlockStyle(
                TextStyle(
                  fontFamily: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.fontFamily,
                  fontSize: 16,
                  height: 1.2,
                  letterSpacing: 0.9,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                HorizontalSpacing(0, 0),
                VerticalSpacing(8, 8),
                VerticalSpacing(6, 6),
                // VerticalSpacing(0, 0),
                // VerticalSpacing(0, 0),
                null,
                const AdaptiveCheckboxBuilder(),
              ),
            ),
          ),
          focusNode: _focusNode,
        ),
      ),
    );
  }
}
