import 'package:flutter/material.dart';
import 'package:fusheng/i18n/strings.g.dart';

import 'package:fusheng/pages/page.dart';

import 'package:fusheng/pages/settings/widgets/font_selection_dialog.dart';
import 'package:fusheng/pages/settings/widgets/list_subtitle.dart';

class Settings extends AppPage {
  const Settings({super.key});

  @override
  Widget title(BuildContext context) => Text(t.settings.title);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListLabel(label: t.settings.appearance.title),
        ListTile(
          leading: const Icon(Icons.text_fields),
          title: Text(t.settings.appearance.font.title),
          subtitle: Text(t.settings.appearance.font.subtitle),
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => FontSelectionDialog(),
          ),
        ),
      ],
    );
  }
}
