///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en: 'Fusheng'
	String get fusheng => 'Fusheng';

	late final Translations$sidebar$en sidebar = Translations$sidebar$en._(_root);
	late final Translations$home$en home = Translations$home$en._(_root);
	late final Translations$settings$en settings = Translations$settings$en._(_root);
}

// Path: sidebar
class Translations$sidebar$en {
	Translations$sidebar$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Life is short, and joy is fleeting.'
	String get slogan => 'Life is short, and joy is fleeting.';
}

// Path: home
class Translations$home$en {
	Translations$home$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get title => 'Home';

	/// en: 'Add a Diary'
	String get addDiary => 'Add a Diary';

	/// en: 'Add a Emotion'
	String get addEmotion => 'Add a Emotion';
}

// Path: settings
class Translations$settings$en {
	Translations$settings$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	late final Translations$settings$appearance$en appearance = Translations$settings$appearance$en._(_root);
}

// Path: settings.appearance
class Translations$settings$appearance$en {
	Translations$settings$appearance$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Appearance'
	String get title => 'Appearance';

	late final Translations$settings$appearance$font$en font = Translations$settings$appearance$font$en._(_root);
}

// Path: settings.appearance.font
class Translations$settings$appearance$font$en {
	Translations$settings$appearance$font$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Font'
	String get title => 'Font';

	/// en: 'Select the UI font you love.'
	String get subtitle => 'Select the UI font you love.';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Default'
	String get Default => 'Default';

	/// en: 'MiSans'
	String get Misans => 'MiSans';

	/// en: 'LXGW Wenkai'
	String get LxgwWenkai => 'LXGW Wenkai';

	/// en: 'Zhuque Serif'
	String get ZhuqueFangsong => 'Zhuque Serif';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'fusheng' => 'Fusheng',
			'sidebar.slogan' => 'Life is short, and joy is fleeting.',
			'home.title' => 'Home',
			'home.addDiary' => 'Add a Diary',
			'home.addEmotion' => 'Add a Emotion',
			'settings.title' => 'Settings',
			'settings.appearance.title' => 'Appearance',
			'settings.appearance.font.title' => 'Font',
			'settings.appearance.font.subtitle' => 'Select the UI font you love.',
			'settings.appearance.font.cancel' => 'Cancel',
			'settings.appearance.font.Default' => 'Default',
			'settings.appearance.font.Misans' => 'MiSans',
			'settings.appearance.font.LxgwWenkai' => 'LXGW Wenkai',
			'settings.appearance.font.ZhuqueFangsong' => 'Zhuque Serif',
			_ => null,
		};
	}
}
