import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_provider.g.dart';

@riverpod
class LanguageController extends _$LanguageController {
  @override
  Future<Locale?> build() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('app_language');
    if (languageCode != null) {
      return Locale(languageCode);
    }
    return null;
  }

  Future<void> setLanguage(Locale? locale) async {
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove('app_language');
    } else {
      await prefs.setString('app_language', locale.languageCode);
    }
    state = AsyncValue.data(locale);
  }
}
