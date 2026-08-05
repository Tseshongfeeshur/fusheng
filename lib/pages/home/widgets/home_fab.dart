import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fusheng/i18n/strings.g.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeFab extends StatefulWidget {
  const HomeFab({super.key});

  @override
  State<HomeFab> createState() => _HomeFabState();
}

class _HomeFabState extends State<HomeFab> {
  @override
  Widget build(BuildContext context) {
    final List<String> emotions = ["😄", "😡", "😔", "🤔", "😭", "😨", "😱"];

    return SpeedDial(
      shape:
          Theme.of(context).floatingActionButtonTheme.shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      overlayOpacity: 0,

      animationDuration: const Duration(milliseconds: 200),
      animationCurve: Curves.easeOutCubic,

      label: Text(t.home.addDiary),
      activeLabel: Text(t.home.addEmotion),

      icon: Icons.add,
      activeIcon: Icons.close,
      useRotationAnimation: false,

      onOpen: () {
        HapticFeedback.successNotification();
      },

      spacing: 8,
      spaceBetweenChildren: 10,
      childrenButtonSize: Size(44, 44),
      childPadding: EdgeInsets.all(0),

      children: emotions.map((emoji) {
        return SpeedDialChild(
          child: Text(emoji, style: const TextStyle(fontSize: 20, height: 1)),
          shape: const CircleBorder(),
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          onTap: () {
            // TODO: 点击表情后的逻辑
          },
        );
      }).toList(),
    );
  }
}
