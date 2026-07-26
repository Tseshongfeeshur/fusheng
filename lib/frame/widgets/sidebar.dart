import 'package:flutter/material.dart';
import 'package:fusheng/frame/frame.dart';
import 'package:fusheng/i18n/strings.g.dart';
import 'package:provider/provider.dart';

class SidebarItem extends StatelessWidget {
  final Icon normalIcon;
  final Icon selectedIcon;
  final String content;
  final int index;
  const SidebarItem({
    super.key,
    required this.normalIcon,
    required this.selectedIcon,
    required this.content,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final selected = context.watch<NavigationModel>().currentIndex == index;

    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(999),
            bottomRight: Radius.circular(999),
          ),
        ),
        leading: selected ? selectedIcon : normalIcon,
        title: Text(
          content,
          style: TextStyle(
            // fontSize: 18,
            fontWeight: selected ? FontWeight(600) : null,
          ),
        ),
        onTap: () {
          context.read<NavigationModel>().setIndex(index);
          Navigator.pop(context);
        },
        selected: selected,
        selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Text(t.sidebar.slogan, style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          SizedBox(height: 8),
          SidebarItem(
            normalIcon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            content: t.home.title,
            index: 0,
          ),
          SidebarItem(
            normalIcon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            content: t.settings.title,
            index: 1,
          ),
        ],
      ),
    );
  }
}
