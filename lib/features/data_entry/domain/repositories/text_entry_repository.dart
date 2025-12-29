import '../entities/text_entry.dart';

/// Repository interface for text entry operations
/// Following Dependency Inversion Principle
abstract class TextEntryRepository {
  /// Submits a text entry
  Future<TextEntry> submitText(String text);

  /// Gets the current submitted text entry
  TextEntry? getCurrentEntry();

  /// Clears the current entry
  void clearEntry();
}
