import '../../domain/entities/text_entry.dart';
import '../../domain/repositories/text_entry_repository.dart';
import '../datasources/text_entry_local_datasource.dart';

/// Implementation of TextEntryRepository
/// Follows Repository pattern - acts as single source of truth
class TextEntryRepositoryImpl implements TextEntryRepository {
  final TextEntryLocalDataSource _localDataSource;

  TextEntryRepositoryImpl(this._localDataSource);

  @override
  Future<TextEntry> submitText(String text) async {
    return await _localDataSource.saveEntry(text);
  }

  @override
  TextEntry? getCurrentEntry() {
    return _localDataSource.getEntry();
  }

  @override
  void clearEntry() {
    _localDataSource.clearEntry();
  }
}
