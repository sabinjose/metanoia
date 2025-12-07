// ignore_for_file: avoid_print

import 'dart:io';

import 'package:encrypt/encrypt.dart' as encrypt_pkg;

/// Build script to encrypt all JSON content files.
///
/// Usage: dart run scripts/encrypt_assets.dart
///
/// This script reads all JSON files from assets/data/ and creates
/// encrypted versions in assets/data_encrypted/ with .enc extension.
void main() async {
  print('🔐 Starting content encryption...\n');

  // Same key and IV as ContentCrypto - must match exactly!
  const keyString = 'M3t4n01a_C0nt3nt_Pr0t3ct10n_K3y!'; // 32 chars for AES-256
  final key = encrypt_pkg.Key.fromUtf8(keyString);
  final iv = encrypt_pkg.IV.fromLength(16);
  final encrypter = encrypt_pkg.Encrypter(
    encrypt_pkg.AES(key, mode: encrypt_pkg.AESMode.cbc),
  );

  final sourceDir = Directory('assets/data');
  final targetDir = Directory('assets/data_encrypted');

  // Verify source directory exists
  if (!sourceDir.existsSync()) {
    print('❌ Error: Source directory assets/data/ does not exist');
    exit(1);
  }

  // Clean and recreate target directory
  if (targetDir.existsSync()) {
    print('🧹 Cleaning existing encrypted assets...');
    targetDir.deleteSync(recursive: true);
  }
  targetDir.createSync(recursive: true);

  int fileCount = 0;
  int totalSize = 0;

  // Process all JSON files
  await for (final entity in sourceDir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.json')) {
      final relativePath = entity.path.replaceFirst('assets/data/', '');
      final targetPath = 'assets/data_encrypted/${relativePath.replaceFirst('.json', '.enc')}';

      // Create subdirectories if needed
      final targetFile = File(targetPath);
      final parentDir = targetFile.parent;
      if (!parentDir.existsSync()) {
        parentDir.createSync(recursive: true);
      }

      // Read, encrypt, and write
      final plainContent = entity.readAsStringSync();
      final encrypted = encrypter.encrypt(plainContent, iv: iv);
      targetFile.writeAsStringSync(encrypted.base64);

      final originalSize = plainContent.length;
      final encryptedSize = encrypted.base64.length;
      totalSize += originalSize;
      fileCount++;

      print('  ✅ $relativePath → ${relativePath.replaceFirst('.json', '.enc')} '
          '(${_formatSize(originalSize)} → ${_formatSize(encryptedSize)})');
    }
  }

  print('\n📊 Summary:');
  print('   Files encrypted: $fileCount');
  print('   Total original size: ${_formatSize(totalSize)}');
  print('\n✨ Encryption complete! Encrypted files are in assets/data_encrypted/');
  print('\n📝 Next steps:');
  print('   1. Run: flutter build apk --release');
  print('   2. The app will automatically use encrypted files in release mode');
}

String _formatSize(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
  return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
}
