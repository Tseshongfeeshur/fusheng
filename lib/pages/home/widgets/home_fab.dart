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
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      elevation: 4,
      shape:
          Theme.of(context).floatingActionButtonTheme.shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),

      overlayOpacity: 0,

      animationDuration: const Duration(milliseconds: 200),
      animationCurve: Curves.easeOutCubic,

      label: Text(t.home.addDiary),
      activeLabel: Text(t.home.addEmotion),

      icon: Icons.add,
      activeIcon: Icons.add,
      animationAngle: 3.1415 / 4,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,

      onOpen: () {
        HapticFeedback.successNotification();
      },
      onClose: () {
        HapticFeedback.lightImpact();
      },

      spacing: 12,

      children: [
        SpeedDialChild(
          child: const Text("😄", style: TextStyle(fontSize: 20)),
          shape: CircleBorder(),
          elevation: 4,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
        SpeedDialChild(
          child: const Text("😡", style: TextStyle(fontSize: 20)),
          shape: CircleBorder(),
          elevation: 4,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
        SpeedDialChild(
          child: const Text("😔", style: TextStyle(fontSize: 20)),
          shape: CircleBorder(),
          elevation: 4,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
        SpeedDialChild(
          child: const Text("🤔", style: TextStyle(fontSize: 20)),
          shape: CircleBorder(),
          elevation: 4,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
        SpeedDialChild(
          child: const Text("😭", style: TextStyle(fontSize: 20)),
          shape: CircleBorder(),
          elevation: 4,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
        SpeedDialChild(
          child: const Text("😨", style: TextStyle(fontSize: 20)),
          shape: CircleBorder(),
          elevation: 4,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
        SpeedDialChild(
          child: const Text("😱", style: TextStyle(fontSize: 20)),
          shape: CircleBorder(),
          elevation: 4,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
      ],
    );
  }
}
