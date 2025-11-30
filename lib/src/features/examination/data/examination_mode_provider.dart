import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'examination_mode_provider.g.dart';

enum ExaminationMode {
  list,
  guided,
}

const _kExaminationModeKey = 'examination_mode';

@riverpod
class ExaminationModeController extends _$ExaminationModeController {
  @override
  ExaminationMode build() {
    _loadFromPrefs();
    return ExaminationMode.list; // Default to list view
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final modeString = prefs.getString(_kExaminationModeKey);
    if (modeString != null) {
      final mode = ExaminationMode.values.firstWhere(
        (e) => e.name == modeString,
        orElse: () => ExaminationMode.list,
      );
      state = mode;
    }
  }

  Future<void> setMode(ExaminationMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kExaminationModeKey, mode.name);
  }

  void toggle() {
    final newMode = state == ExaminationMode.list
        ? ExaminationMode.guided
        : ExaminationMode.list;
    setMode(newMode);
  }
}
