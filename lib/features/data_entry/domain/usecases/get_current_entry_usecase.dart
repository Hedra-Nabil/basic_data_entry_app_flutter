import '../entities/text_entry.dart';
import '../repositories/text_entry_repository.dart';

/// Use case for getting the current submitted text entry
class GetCurrentEntryUseCase {
  final TextEntryRepository _repository;

  GetCurrentEntryUseCase(this._repository);

  /// Executes the use case
  /// Returns the current [TextEntry] or null if none exists
  TextEntry? call() {
    return _repository.getCurrentEntry();
  }
}
