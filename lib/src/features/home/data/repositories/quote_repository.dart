import 'dart:convert';
import 'dart:ui';
import 'package:confessionapp/src/core/utils/content_crypto.dart';
import 'package:confessionapp/src/features/home/domain/models/quote.dart';

class QuoteRepository {
  Future<List<Quote>> getQuotes(Locale locale) async {
    try {
      // Determine the file path based on the locale
      final String languageCode = locale.languageCode;
      final String filePath = 'assets/data/quotes/quotes_$languageCode.json';

      // Load the JSON file from assets (encrypted in release mode)
      // Fallback to English if the specific locale file doesn't exist
      String jsonString;
      try {
        jsonString = await ContentCrypto.loadContent(filePath);
      } catch (e) {
        // Fallback to English if file not found
        jsonString = await ContentCrypto.loadContent(
          'assets/data/quotes/quotes_en.json',
        );
      }

      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => Quote.fromJson(json)).toList();
    } catch (e) {
      // Return empty list or throw error, handled by provider
      return [];
    }
  }
}
