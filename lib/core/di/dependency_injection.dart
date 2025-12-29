import '../../features/data_entry/data_entry.dart';

/// Simple Dependency Injection container
/// Provides singleton instances of dependencies
class DependencyInjection {
  DependencyInjection._();

  static final DependencyInjection _instance = DependencyInjection._();
  static DependencyInjection get instance => _instance;

  // Data sources
  late final TextEntryLocalDataSource _localDataSource;

  // Repositories
  late final TextEntryRepository _textEntryRepository;

  // Use cases
  late final SubmitTextUseCase _submitTextUseCase;
  late final GetCurrentEntryUseCase _getCurrentEntryUseCase;

  /// Initializes all dependencies
  void init() {
    // Initialize data sources
    _localDataSource = TextEntryLocalDataSource();

    // Initialize repositories
    _textEntryRepository = TextEntryRepositoryImpl(_localDataSource);

    // Initialize use cases
    _submitTextUseCase = SubmitTextUseCase(_textEntryRepository);
    _getCurrentEntryUseCase = GetCurrentEntryUseCase(_textEntryRepository);
  }

  /// Creates a new DataEntryController with injected dependencies
  DataEntryController createDataEntryController() {
    return DataEntryController(
      submitTextUseCase: _submitTextUseCase,
      getCurrentEntryUseCase: _getCurrentEntryUseCase,
    );
  }
}

/// Shorthand for accessing DI instance
DependencyInjection get di => DependencyInjection.instance;
