import 'package:flutter/material.dart';
import '../../domain/entities/text_entry.dart';
import '../../domain/usecases/submit_text_usecase.dart';
import '../../domain/usecases/get_current_entry_usecase.dart';

/// State management for Data Entry feature
/// Uses ChangeNotifier for simple, clean state management
class DataEntryController extends ChangeNotifier {
  final SubmitTextUseCase _submitTextUseCase;
  final GetCurrentEntryUseCase _getCurrentEntryUseCase;

  DataEntryController({
    required SubmitTextUseCase submitTextUseCase,
    required GetCurrentEntryUseCase getCurrentEntryUseCase,
  }) : _submitTextUseCase = submitTextUseCase,
       _getCurrentEntryUseCase = getCurrentEntryUseCase;

  // State
  TextEntry? _currentEntry;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  TextEntry? get currentEntry => _currentEntry;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasSubmittedText => _currentEntry?.hasContent ?? false;
  String get submittedText => _currentEntry?.text ?? '';

  /// Submits text and updates state
  Future<void> submitText(String text) async {
    if (text.trim().isEmpty) {
      _errorMessage = 'Please enter some text';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentEntry = await _submitTextUseCase(text);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clears any error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Initializes by loading any existing entry
  void initialize() {
    _currentEntry = _getCurrentEntryUseCase();
    notifyListeners();
  }
}
