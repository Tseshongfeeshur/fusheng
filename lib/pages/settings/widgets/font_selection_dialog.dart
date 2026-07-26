import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fusheng/i18n/strings.g.dart';

import 'package:fusheng/frame/data/fonts.dart';
import 'package:fusheng/frame/frame.dart';

class FontSelectionDialog extends StatelessWidget {
  const FontSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final fontModel = context.watch<FontSwitchModel>();

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 22, 0, 12),
            child: Text(
              t.settings.appearance.font.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Divider(),
          RadioGroup<String>(
            groupValue: fontModel.currentFont,
            onChanged: (String? val) {
              fontModel.setFont(val);
              if (context.mounted) Navigator.pop(context);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: fonts
                  .map(
                    (str) => RadioListTile<String>(
                      title: Text(
                        t['settings.appearance.font.$str'] ?? str,
                        style: TextStyle(fontFamily: str),
                      ),
                      value: str,
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: Text(t.settings.appearance.font.cancel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
