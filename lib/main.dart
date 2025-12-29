import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'core/di/dependency_injection.dart';
import 'features/data_entry/data_entry.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize dependency injection
  di.init();

  runApp(const DataEntryApp());
}

/// Main application widget
class DataEntryApp extends StatelessWidget {
  const DataEntryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: DataEntryScreen(controller: di.createDataEntryController()),
    );
  }
}
