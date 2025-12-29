import '../../domain/entities/text_entry.dart';

/// Local data source for text entry operations
/// Handles in-memory storage of text entries
class TextEntryLocalDataSource {
  TextEntry? _currentEntry;

  /// Saves a text entry locally
  Future<TextEntry> saveEntry(String text) async {
    // Simulate async operation (could be database/shared preferences in future)
    await Future.delayed(const Duration(milliseconds: 100));

    _currentEntry = TextEntry(text: text, submittedAt: DateTime.now());

    return _currentEntry!;
  }

  /// Gets the current stored entry
  TextEntry? getEntry() {
    return _currentEntry;
  }

  /// Clears the stored entry
  void clearEntry() {
    _currentEntry = null;
  }
}
