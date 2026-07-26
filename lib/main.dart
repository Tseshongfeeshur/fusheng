import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fusheng/i18n/strings.g.dart';

import 'package:system_theme/system_theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'package:fusheng/frame/frame.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  SystemTheme.fallbackColor = Colors.purple;
  await SystemTheme.accentColor.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationModel()),
        ChangeNotifierProvider(create: (_) => FontSwitchModel()),
      ],
      child: TranslationProvider(child: MainApp()),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final fontModel = context.watch<FontSwitchModel>();

    return SystemThemeBuilder(
      builder: (context, accent) {
        final FlexSchemeData materialFlexScheme = FlexSchemeData(
          name: 'Material',
          description: 'Material Flex Colors.',
          light: FlexSchemeColor.from(
            primary: accent.accent,
            brightness: Brightness.light,
          ),
          dark: FlexSchemeColor.from(
            primary: accent.accent,
            brightness: Brightness.dark,
          ),
        );
        return MaterialApp(
          theme: FlexThemeData.light(
            colors: materialFlexScheme.light,
            keyColors: const FlexKeyColors(),
            splashFactory: InkSparkle.splashFactory,
            subThemesData: const FlexSubThemesData(interactionEffects: true),
            fontFamily: fontModel.currentFont,
          ),
          darkTheme: FlexThemeData.dark(
            colors: materialFlexScheme.dark,
            keyColors: const FlexKeyColors(),
            splashFactory: InkSparkle.splashFactory,
            subThemesData: const FlexSubThemesData(interactionEffects: true),
            fontFamily: fontModel.currentFont,
          ),
          themeMode: ThemeMode.system,
          home: AppFrame(),
        );
      },
    );
  }
}
