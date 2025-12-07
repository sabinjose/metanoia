import 'package:encrypt/encrypt.dart' as encrypt_pkg;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Handles encryption and decryption of JSON content assets.
///
/// In debug mode, loads plain JSON files directly for faster development.
/// In release mode, loads and decrypts encrypted `.enc` files.
class ContentCrypto {
  ContentCrypto._();

  // Key stored as char codes to avoid extraction via `strings` command
  // ignore: unused_field
  static final _keyChars = <int>[
    0x4D, 0x33, 0x74, 0x34, 0x6E, 0x30, 0x31, 0x61, // M3t4n01a
    0x5F, 0x43, 0x30, 0x6E, 0x74, 0x33, 0x6E, 0x74, // _C0nt3nt
    0x5F, 0x50, 0x72, 0x30, 0x74, 0x33, 0x63, 0x74, // _Pr0t3ct
    0x31, 0x30, 0x6E, 0x5F, 0x4B, 0x33, 0x79, 0x21, // 10n_K3y!
  ];
  static final _key = encrypt_pkg.Key(Uint8List.fromList(_keyChars));
  static final _iv = encrypt_pkg.IV.fromLength(16);
  static final _encrypter = encrypt_pkg.Encrypter(
    encrypt_pkg.AES(_key, mode: encrypt_pkg.AESMode.cbc),
  );

  /// Loads content from the appropriate source based on build mode.
  ///
  /// - Debug: Loads plain JSON from `assets/data/`
  /// - Release: Loads encrypted content from `assets/data_encrypted/`
  static Future<String> loadContent(String assetPath) async {
    if (kDebugMode) {
      // In debug mode, load plain JSON directly
      return rootBundle.loadString(assetPath);
    } else {
      // In release mode, load and decrypt
      final encryptedPath = _getEncryptedPath(assetPath);
      final encryptedContent = await rootBundle.loadString(encryptedPath);
      return decrypt(encryptedContent);
    }
  }

  /// Converts a plain asset path to its encrypted equivalent.
  ///
  /// Example: `assets/data/prayers/prayers_en.json`
  /// becomes: `assets/data_encrypted/prayers/prayers_en.enc`
  static String _getEncryptedPath(String plainPath) {
    return plainPath
        .replaceFirst('assets/data/', 'assets/data_encrypted/')
        .replaceFirst('.json', '.enc');
  }

  /// Encrypts a JSON string for build-time processing.
  ///
  /// Used by the build script to encrypt assets.
  static String encrypt(String plainText) {
    final encrypted = _encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  /// Decrypts an encrypted string back to JSON.
  ///
  /// Used at runtime to decrypt loaded content.
  static String decrypt(String encryptedText) {
    final encrypted = encrypt_pkg.Encrypted.fromBase64(encryptedText);
    return _encrypter.decrypt(encrypted, iv: _iv);
  }

  /// Validates that decryption works correctly.
  ///
  /// Used for testing the encryption/decryption cycle.
  static bool validateEncryption(String original) {
    final encrypted = encrypt(original);
    final decrypted = decrypt(encrypted);
    return original == decrypted;
  }
}
