import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';
import 'package:fusheng/i18n/strings.g.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'package:fusheng/frame/frame.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

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

/// 亮色方案。
/// 背景、正文文字都不用纯黑/纯白 —— 大面积纯黑白容易产生视觉振动感，
/// 长时间阅读会累眼睛。数值参考 Material Design 暗色/亮色主题规范里
/// "文字不用纯色，用约 87%/60% 不透明度的黑或白" 这条经验值。
/// 卡片这类小面积的提升表面仍然可以用接近纯白的颜色，
/// 问题只出在"大面积"上，小面积高亮反而是需要的层次感。
const ColorScheme hardLightScheme = ColorScheme(
  brightness: Brightness.light,

  primary: Color(0xFF1A1A1A), // 柔和黑，而非 Colors.black
  onPrimary: Color(0xFFFAFAFA), // 柔和白，而非 Colors.white
  primaryContainer: Color(0xFFEFEFEF),
  onPrimaryContainer: Color(0xFF1F1F1F),

  secondary: Color(0xFF404040),
  onSecondary: Color(0xFFFAFAFA),
  secondaryContainer: Color(0xFFECECEC),
  onSecondaryContainer: Color(0xFF1F1F1F),

  tertiary: Color(0xFF6E6E6E),
  onTertiary: Color(0xFFFAFAFA),
  tertiaryContainer: Color(0xFFF6F6F6),
  onTertiaryContainer: Color(0xFF1F1F1F),

  surface: Color(0xFFF6F6F6), // 页面背景：柔和白，不是 Colors.white
  onSurface: Color(0xFF1F1F1F), // 正文文字：柔和黑，不是 Colors.black
  surfaceContainerHighest: Color(0xFFFFFFFF), // 卡片：小面积，可以更亮
  onSurfaceVariant: Color(0xFF5F5F5F), // 次要文字
  inverseSurface: Color(0xFF1F1F1F),
  onInverseSurface: Color(0xFFFAFAFA),
  inversePrimary: Color(0xFFFAFAFA),

  outline: Color(0xFF1F1F1F), // 边框：线条细，不算"大面积"，可以保留够重的颜色
  outlineVariant: Color(0xFF1F1F1F),
  shadow: Colors.transparent,
  scrim: Color(0x8A000000),
  surfaceTint: Colors.transparent,

  error: Color(0xFFB3261E),
  onError: Color(0xFFFAFAFA),
  errorContainer: Color(0xFFF6F6F6),
  onErrorContainer: Color(0xFFB3261E),
);

/// 暗色方案：不是亮色方案的数学反色，是按同样的"别用纯色"原则独立设计的。
/// 背景 0x121212、卡片 0x1E1E1E、正文 0xE0E0E0、次要文字 0xB0B0B0
/// 这几个数值是 Material Design 暗色主题规范里的标准参考值，
/// 不是随便取的——如果直接反色亮色方案的背景（0xF6F6F6），
/// 算出来会是 0x090909，几乎还是纯黑，等于没解决问题。
const ColorScheme hardDarkScheme = ColorScheme(
  brightness: Brightness.dark,

  primary: Color(0xFFEDEDED),
  onPrimary: Color(0xFF121212),
  primaryContainer: Color(0xFF1E1E1E),
  onPrimaryContainer: Color(0xFFEDEDED),

  secondary: Color(0xFFB8B8B8),
  onSecondary: Color(0xFF121212),
  secondaryContainer: Color(0xFF262626),
  onSecondaryContainer: Color(0xFFEDEDED),

  tertiary: Color(0xFF9E9E9E),
  onTertiary: Color(0xFF121212),
  tertiaryContainer: Color(0xFF1E1E1E),
  onTertiaryContainer: Color(0xFFEDEDED),

  surface: Color(0xFF121212), // 页面背景：Material 暗色规范推荐值，不是纯黑
  onSurface: Color(0xFFE0E0E0), // 正文文字：约 87% 白，不是纯白
  surfaceContainerHighest: Color(0xFF1E1E1E), // 卡片：比背景稍亮一档
  onSurfaceVariant: Color(0xFFB0B0B0), // 次要文字：约 60% 白
  inverseSurface: Color(0xFFEDEDED),
  onInverseSurface: Color(0xFF121212),
  inversePrimary: Color(0xFF121212),

  outline: Color(0xFFE0E0E0),
  outlineVariant: Color(0xFFE0E0E0),
  shadow: Colors.transparent,
  scrim: Color(0x8A000000), // 遮罩两种主题下都保持深色压暗效果
  surfaceTint: Colors.transparent,

  error: Color(0xFFF2938E), // 比亮色态的红更亮一档，暗背景上才够醒目
  onError: Color(0xFF121212),
  errorContainer: Color(0xFF1E1E1E),
  onErrorContainer: Color(0xFFF2938E),
);

// ，直角、无阴影、粗边框，
/// 颜色不在这里管，全部交给上面两套 ColorScheme。
const _hardSubThemes = FlexSubThemesData(
  interactionEffects: true,

  defaultRadius: 0,
  elevatedButtonRadius: 0,
  outlinedButtonRadius: 0,
  textButtonRadius: 0,
  toggleButtonsRadius: 0,
  segmentedButtonRadius: 0,
  cardRadius: 0,
  popupMenuRadius: 0,
  dialogRadius: 0,
  timePickerDialogRadius: 0,
  datePickerDialogRadius: 0,
  bottomSheetRadius: 0,
  inputDecoratorRadius: 0,
  chipRadius: 0,
  tooltipRadius: 0,
  snackBarRadius: 0,
  drawerRadius: 0,
  menuRadius: 0,
  fabRadius: 0,
  menuBarRadius: 0,
  searchBarRadius: 0,
  searchViewRadius: 0,
  filledButtonRadius: 0,
  menuIndicatorRadius: 0,
  drawerIndicatorRadius: 0,
  timePickerElementRadius: 0,
  tabBarIndicatorTopRadius: 0,
  navigationBarIndicatorRadius: 0,
  navigationRailIndicatorRadius: 0,
  progressIndicatorLinearRadius: 0,
  progressIndicatorStopIndicatorRadius: 0,
  dialogRadiusAdaptive: 0,
  defaultRadiusAdaptive: 0,
  inputDecoratorRadiusAdaptive: 0,

  elevatedButtonElevation: 0,
  cardElevation: 0,
  appBarScrolledUnderElevation: 0,
  dialogElevation: 0,
  popupMenuElevation: 0,
  bottomSheetElevation: 0,
  bottomSheetModalElevation: 0,
  snackBarElevation: 0,
  drawerElevation: 0,
  menuElevation: 0,
  menuBarElevation: 0,
  searchBarElevation: 0,
  searchViewElevation: 0,
  navigationBarElevation: 0,
  navigationRailElevation: 0,
  bottomNavigationBarElevation: 0,

  thinBorderWidth: 2,
  thickBorderWidth: 3,
  outlinedButtonBorderWidth: 2,
  toggleButtonsBorderWidth: 2,
  segmentedButtonBorderWidth: 2,
  inputDecoratorBorderWidth: 2,
  inputDecoratorFocusedBorderWidth: 3,
  inputDecoratorBorderType: FlexInputBorderType.outline,
  inputDecoratorUnfocusedHasBorder: true,
);

/// 用固定的 ColorScheme（而非种子色/色调板）生成主题，
/// subThemesData 只负责形状/边框/阴影，颜色完全由 colorScheme 决定。
ThemeData _buildHardTheme(ColorScheme scheme, String? fontFamily) {
  final base = scheme.brightness == Brightness.light
      ? FlexThemeData.light(
          colorScheme: scheme,
          subThemesData: _hardSubThemes,
          fontFamily: fontFamily,
          appBarElevation: 0,
        )
      : FlexThemeData.dark(
          colorScheme: scheme,
          subThemesData: _hardSubThemes,
          fontFamily: fontFamily,
          appBarElevation: 0,
        );

  // FlexSubThemesData 没有给 Card/Dialog 提供边框颜色参数，
  // 在这里补一层直角 + 粗边框，颜色统一取 colorScheme.outline。
  return base.copyWith(
    splashFactory: NoSplash.splashFactory,
    cardTheme: base.cardTheme.copyWith(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: scheme.outline, width: 2),
      ),
    ),
    dialogTheme: base.dialogTheme.copyWith(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: scheme.outline, width: 2),
      ),
    ),
    dividerTheme: base.dividerTheme.copyWith(
      color: scheme.outlineVariant,
      thickness: 1,
      space: 1,
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final fontModel = context.watch<FontSwitchModel>();

    final translation = TranslationProvider.of(context);

    return MaterialApp(
      locale: translation.flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],

      theme: _buildHardTheme(hardLightScheme, fontModel.currentFont),
      darkTheme: _buildHardTheme(hardDarkScheme, fontModel.currentFont),
      themeMode: ThemeMode.system,
      home: AppFrame(),
    );
  }
}
