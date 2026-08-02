import 'package:flutter/material.dart';
import 'package:fusheng/i18n/strings.g.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: Border.all(
        color: Theme.of(context).colorScheme.outline,
        width: 1.6,
      ),
      position: PopupMenuPosition.under,
      icon: Icon(Icons.more_vert),
      onSelected: (value) {},
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.new_label_outlined),
              SizedBox(width: 8),
              Text(t.creater.menu.tags),
            ],
          ),
        ),
        PopupMenuItem<String>(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.share_outlined),
              SizedBox(width: 8),
              Text(t.creater.menu.share),
            ],
          ),
        ),
        PopupMenuItem<String>(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.drive_file_rename_outline_outlined),
              SizedBox(width: 8),
              Text(t.creater.menu.import),
            ],
          ),
        ),
        PopupMenuItem<String>(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.search),
              SizedBox(width: 8),
              Text(t.creater.menu.search),
            ],
          ),
        ),
      ],
    );
  }
}
