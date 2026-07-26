import 'package:flutter/material.dart';
import 'package:fusheng/i18n/strings.g.dart';

import 'package:fusheng/pages/page.dart';

import 'package:fusheng/pages/home/widgets/home_fab.dart';

class Home extends AppPage {
  const Home({super.key});

  @override
  Widget title(BuildContext context) => Text(t.home.title);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Widget fab(BuildContext context) => HomeFab();
}
