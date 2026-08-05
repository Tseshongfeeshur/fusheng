import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_quill/flutter_quill.dart';
import 'package:fusheng/i18n/strings.g.dart';

const String docJson =
    r'[{"insert":"一级标题"},{"insert":"\n","attributes":{"header":1}},{"insert":"二级标题"},{"insert":"\n","attributes":{"header":2}},{"insert":"三级标题"},{"insert":"\n","attributes":{"header":3}},{"insert":"这是正文，"},{"insert":"这是加粗","attributes":{"bold":true}},{"insert":"，"},{"insert":"这是斜体","attributes":{"italic":true}},{"insert":"，"},{"insert":"这是下划线","attributes":{"underline":true}},{"insert":"，"},{"insert":"这是删除线","attributes":{"strike":true}},{"insert":"，"},{"insert":"这是前景色","attributes":{"color":"#FFD50000"}},{"insert":"，"},{"insert":"这是背景色","attributes":{"background":"#FFFFFF00"}},{"insert":"，"},{"insert":"这是上标","attributes":{"script":"super"}},{"insert":"，"},{"insert":"这是下标","attributes":{"script":"sub"}},{"insert":"，"},{"insert":"This is inline code","attributes":{"code":true}},{"insert":"，"},{"insert":"这是链接","attributes":{"link":"https://example.com/"}},{"insert":"。\n"},{"insert":"这是有序列表第一项"},{"insert":"\n","attributes":{"list":"ordered"}},{"insert":"这是有序列表第二项"},{"insert":"\n","attributes":{"list":"ordered"}},{"insert":"这是有序列表第三项"},{"insert":"\n","attributes":{"list":"ordered"}},{"insert":"这是无序列表第一项"},{"insert":"\n","attributes":{"list":"bullet"}},{"insert":"这是无序列表第二项"},{"insert":"\n","attributes":{"list":"bullet"}},{"insert":"这是无序列表第三项"},{"insert":"\n","attributes":{"list":"bullet"}},{"insert":"这是待办列表第一项"},{"insert":"\n","attributes":{"list":"unchecked"}},{"insert":"这是待办列表第一项"},{"insert":"\n","attributes":{"list":"unchecked"}},{"insert":"这是待办列表第一项"},{"insert":"\n","attributes":{"list":"unchecked"}},{"insert":"这是引用块"},{"insert":"\n","attributes":{"blockquote":true}},{"insert":"It is code block."},{"insert":"\n","attributes":{"code-block":true}}]';

class PopupMenu extends StatelessWidget {
  final QuillController controller;
  const PopupMenu({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
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
          onTap: () {
            HapticFeedback.successNotification();
            controller.document = Document.fromJson(jsonDecode(docJson));
          },
        ),
        PopupMenuItem<String>(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.download_outlined),
              SizedBox(width: 8),
              Text(t.creater.menu.export),
            ],
          ),
          onTap: () {
            HapticFeedback.successNotification();
            final String docJson = jsonEncode(
              controller.document.toDelta().toJson(),
            );
            debugPrint(docJson);
          },
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
