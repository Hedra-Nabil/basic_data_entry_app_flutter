import 'package:flutter/foundation.dart';

/// Entity representing submitted text data
@immutable
class TextEntry {
  final String text;
  final DateTime submittedAt;

  const TextEntry({required this.text, required this.submittedAt});

  /// Creates an empty text entry
  factory TextEntry.empty() {
    return TextEntry(text: '', submittedAt: DateTime.now());
  }

  /// Check if the entry has content
  bool get hasContent => text.isNotEmpty;

  /// Creates a copy with updated values
  TextEntry copyWith({String? text, DateTime? submittedAt}) {
    return TextEntry(
      text: text ?? this.text,
      submittedAt: submittedAt ?? this.submittedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TextEntry &&
        other.text == text &&
        other.submittedAt == submittedAt;
  }

  @override
  int get hashCode => text.hashCode ^ submittedAt.hashCode;

  @override
  String toString() => 'TextEntry(text: $text, submittedAt: $submittedAt)';
}
