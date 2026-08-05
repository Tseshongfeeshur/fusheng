import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:fusheng/pages/creater/data/quill_buttons.dart';

class BottomPanelContent extends StatelessWidget {
  final QuillController controller;
  const BottomPanelContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: GridView.count(
          crossAxisCount: 5,
          mainAxisSpacing: 16,
          crossAxisSpacing: 10,
          childAspectRatio: 0.9,
          padding: const EdgeInsets.all(10),
          children: QuillAction.values
              .map((action) => action.buildPanelItem(context, controller))
              .toList(),
        ),
      ),
    );
  }
}
