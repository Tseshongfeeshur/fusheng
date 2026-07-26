import 'package:flutter/material.dart';

abstract class AppPage extends StatelessWidget {
  const AppPage({super.key});

  Widget title(BuildContext context);

  Widget? fab(BuildContext context) => null;
}
