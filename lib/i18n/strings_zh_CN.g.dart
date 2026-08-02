///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsZhCn with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZhCn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zhCn,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-CN>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZhCn _root = this; // ignore: unused_field

	@override 
	TranslationsZhCn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZhCn(meta: meta ?? this.$meta);

	// Translations
	@override String get fusheng => '浮生';
	@override late final _Translations$sidebar$zh_CN sidebar = _Translations$sidebar$zh_CN._(_root);
	@override late final _Translations$home$zh_CN home = _Translations$home$zh_CN._(_root);
	@override late final _Translations$settings$zh_CN settings = _Translations$settings$zh_CN._(_root);
	@override late final _Translations$creater$zh_CN creater = _Translations$creater$zh_CN._(_root);
}

// Path: sidebar
class _Translations$sidebar$zh_CN implements Translations$sidebar$en {
	_Translations$sidebar$zh_CN._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get slogan => '浮生若梦，欢日几何？';
}

// Path: home
class _Translations$home$zh_CN implements Translations$home$en {
	_Translations$home$zh_CN._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '主页';
	@override String get addDiary => '新建日记';
	@override String get addEmotion => '记录心情';
}

// Path: settings
class _Translations$settings$zh_CN implements Translations$settings$en {
	_Translations$settings$zh_CN._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '设置';
	@override late final _Translations$settings$appearance$zh_CN appearance = _Translations$settings$appearance$zh_CN._(_root);
}

// Path: creater
class _Translations$creater$zh_CN implements Translations$creater$en {
	_Translations$creater$zh_CN._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final _Translations$creater$menu$zh_CN menu = _Translations$creater$menu$zh_CN._(_root);
	@override late final _Translations$creater$actions$zh_CN actions = _Translations$creater$actions$zh_CN._(_root);
}

// Path: settings.appearance
class _Translations$settings$appearance$zh_CN implements Translations$settings$appearance$en {
	_Translations$settings$appearance$zh_CN._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '外观';
	@override late final _Translations$settings$appearance$font$zh_CN font = _Translations$settings$appearance$font$zh_CN._(_root);
}

// Path: creater.menu
class _Translations$creater$menu$zh_CN implements Translations$creater$menu$en {
	_Translations$creater$menu$zh_CN._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get tags => '标签';
	@override String get share => '分享';
	@override String get import => '导入';
	@override String get search => '搜索 / 替换';
}

// Path: creater.actions
class _Translations$creater$actions$zh_CN implements Translations$creater$actions$en {
	_Translations$creater$actions$zh_CN._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '标题';
	@override String get list => '列表';
	@override String get quote => '引用';
}

// Path: settings.appearance.font
class _Translations$settings$appearance$font$zh_CN implements Translations$settings$appearance$font$en {
	_Translations$settings$appearance$font$zh_CN._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '字体';
	@override String get subtitle => '选择你喜欢的 UI 显示字体。';
	@override String get cancel => '取消';
	@override String get Default => '默认';
	@override String get Misans => 'MiSans';
	@override String get LxgwWenkai => '霞鹜文楷';
	@override String get ZhuqueFangsong => '朱雀仿宋';
}

/// The flat map containing all translations for locale <zh-CN>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZhCn {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'fusheng' => '浮生',
			'sidebar.slogan' => '浮生若梦，欢日几何？',
			'home.title' => '主页',
			'home.addDiary' => '新建日记',
			'home.addEmotion' => '记录心情',
			'settings.title' => '设置',
			'settings.appearance.title' => '外观',
			'settings.appearance.font.title' => '字体',
			'settings.appearance.font.subtitle' => '选择你喜欢的 UI 显示字体。',
			'settings.appearance.font.cancel' => '取消',
			'settings.appearance.font.Default' => '默认',
			'settings.appearance.font.Misans' => 'MiSans',
			'settings.appearance.font.LxgwWenkai' => '霞鹜文楷',
			'settings.appearance.font.ZhuqueFangsong' => '朱雀仿宋',
			'creater.menu.tags' => '标签',
			'creater.menu.share' => '分享',
			'creater.menu.import' => '导入',
			'creater.menu.search' => '搜索 / 替换',
			'creater.actions.title' => '标题',
			'creater.actions.list' => '列表',
			'creater.actions.quote' => '引用',
			_ => null,
		};
	}
}
