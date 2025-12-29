// Data Entry Feature Exports
// Clean Architecture barrel file for easy imports

// Domain Layer
export 'domain/entities/text_entry.dart';
export 'domain/repositories/text_entry_repository.dart';
export 'domain/usecases/submit_text_usecase.dart';
export 'domain/usecases/get_current_entry_usecase.dart';

// Data Layer
export 'data/datasources/text_entry_local_datasource.dart';
export 'data/repositories/text_entry_repository_impl.dart';

// Presentation Layer
export 'presentation/controllers/data_entry_controller.dart';
export 'presentation/screens/data_entry_screen.dart';
export 'presentation/widgets/header_card.dart';
export 'presentation/widgets/text_input_card.dart';
export 'presentation/widgets/submit_button.dart';
export 'presentation/widgets/submitted_text_card.dart';
export 'presentation/widgets/custom_card.dart';
