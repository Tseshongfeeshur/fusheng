import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fusheng/i18n/strings.g.dart';

class BottomPanelItem extends StatelessWidget {
  final VoidCallback onTap;
  final Icon icon;
  final String label;
  const BottomPanelItem({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        IconButton(
          onPressed: () {
            HapticFeedback.successNotification();
            onTap();
          },
          icon: icon,
        ),
        // SizedBox(height: 0),
        Text(label, style: TextStyle(fontSize: 13)),
      ],
    );
  }
}

class BottomPanelContent extends StatelessWidget {
  const BottomPanelContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: GridView.count(
        crossAxisCount: 5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.9,
        padding: const EdgeInsets.all(10),
        children: [
          BottomPanelItem(
            onTap: () {},
            icon: Icon(Icons.title),
            label: t.creater.actions.title,
          ),
          BottomPanelItem(
            onTap: () {},
            icon: Icon(Icons.list),
            label: t.creater.actions.list,
          ),
          BottomPanelItem(
            onTap: () {},
            icon: Icon(Icons.format_quote),
            label: t.creater.actions.quote,
          ),
          BottomPanelItem(
            onTap: () {},
            icon: Icon(Icons.title),
            label: t.creater.actions.title,
          ),
          BottomPanelItem(
            onTap: () {},
            icon: Icon(Icons.list),
            label: t.creater.actions.list,
          ),
          BottomPanelItem(
            onTap: () {},
            icon: Icon(Icons.format_quote),
            label: t.creater.actions.quote,
          ),
          BottomPanelItem(
            onTap: () {},
            icon: Icon(Icons.title),
            label: t.creater.actions.title,
          ),
          BottomPanelItem(
            onTap: () {},
            icon: Icon(Icons.list),
            label: t.creater.actions.list,
          ),
          BottomPanelItem(
            onTap: () {},
            icon: Icon(Icons.format_quote),
            label: t.creater.actions.quote,
          ),
        ],
      ),
    );
  }
}
