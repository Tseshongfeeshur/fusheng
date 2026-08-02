import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:fusheng/pages/test/time_line_1.dart';
// import 'package:fusheng/pages/test/color_scheme.dart';
import 'package:fusheng/pages/creater/creater.dart';
import 'package:fusheng/frame/widgets/sidebar.dart';

import 'package:fusheng/frame/data/fonts.dart';
import 'package:fusheng/pages/page.dart';

import 'package:fusheng/pages/home/home.dart';
import 'package:fusheng/pages/settings/settings.dart';

// 字体切换状态模型
class FontSwitchModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  String get currentFont => fonts[_currentIndex];

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void setFont(String? font) {
    if (font != null && fonts.contains(font)) {
      _currentIndex = fonts.indexOf(font);
    }
    notifyListeners();
  }
}

// 页面导航状态模型
class NavigationModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class AppFrame extends StatelessWidget {
  AppFrame({super.key});

  final List<AppPage> _pages = [Home(), Settings()];

  @override
  Widget build(BuildContext context) {
    final navModel = context.watch<NavigationModel>();
    final currentPage = _pages[navModel.currentIndex];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: GestureDetector(
          child: currentPage.title(context),
          onLongPress: () {
            HapticFeedback.lightImpact();
            Navigator.push(
              context,
              MaterialPageRoute(
                // builder: (BuildContext context) => ColorSchemeDebugger(),
                // builder: (BuildContext context) => DiaryTimelinePage(),
                builder: (BuildContext context) => Creater(),
              ),
            );
          },
        ),
      ),
      drawer: Sidebar(),
      onDrawerChanged: (isOpened) {
        if (isOpened) HapticFeedback.successNotification();
      },
      body: currentPage,
      floatingActionButton: currentPage.fab(context),
    );
  }
}
