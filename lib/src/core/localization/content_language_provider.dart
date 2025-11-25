import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'content_language_provider.g.dart';

@riverpod
class ContentLanguageController extends _$ContentLanguageController {
  @override
  Future<Locale> build() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('content_language') ?? 'en';
    return Locale(languageCode);
  }

  Future<void> setLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('content_language', locale.languageCode);
    state = AsyncValue.data(locale);
  }
}
