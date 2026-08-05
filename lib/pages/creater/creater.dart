import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:fusheng/pages/creater/widgets/optimized_editor.dart';

import 'package:fusheng/pages/creater/widgets/popup_menu.dart';
import 'package:fusheng/pages/creater/widgets/bottom_panel.dart';

class Creater extends StatefulWidget {
  const Creater({super.key});

  @override
  State<Creater> createState() => _CreaterState();
}

class _CreaterState extends State<Creater> {
  late QuillController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 禁止 Flutter 处理键盘避让
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.undo)),
          IconButton(onPressed: () {}, icon: Icon(Icons.redo)),
          SizedBox(width: 8),
          PopupMenu(controller: _controller),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: OptimizedEditor(
              controller: _controller,
              focusNode: _focusNode,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomPanel(
        focusNode: _focusNode,
        quillController: _controller,
      ),
    );
  }
}
