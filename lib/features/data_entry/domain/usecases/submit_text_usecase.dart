import '../entities/text_entry.dart';
import '../repositories/text_entry_repository.dart';

/// Use case for submitting text
/// Single Responsibility: Only handles text submission logic
class SubmitTextUseCase {
  final TextEntryRepository _repository;

  SubmitTextUseCase(this._repository);

  /// Executes the use case
  /// Returns [TextEntry] if successful
  /// Throws [ArgumentError] if text is empty
  Future<TextEntry> call(String text) async {
    final trimmedText = text.trim();

    if (trimmedText.isEmpty) {
      throw ArgumentError('Text cannot be empty');
    }

    return await _repository.submitText(trimmedText);
  }
}
