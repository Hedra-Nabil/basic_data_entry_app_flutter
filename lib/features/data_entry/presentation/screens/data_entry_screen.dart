import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../controllers/data_entry_controller.dart';
import '../widgets/header_card.dart';
import '../widgets/text_input_card.dart';
import '../widgets/submit_button.dart';
import '../widgets/submitted_text_card.dart';

/// Main screen for data entry feature
/// Follows Single Responsibility - only handles UI layout
class DataEntryScreen extends StatefulWidget {
  final DataEntryController controller;

  const DataEntryScreen({super.key, required this.controller});

  @override
  State<DataEntryScreen> createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    widget.controller.initialize();
    widget.controller.addListener(_onControllerUpdate);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerUpdate);
    _textController.dispose();
    super.dispose();
  }

  void _onControllerUpdate() {
    setState(() {});
  }

  void _onSubmit() {
    widget.controller.submitText(_textController.text);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppDimensions.spacingL),

              // Header section
              const HeaderCard(),

              const SizedBox(height: AppDimensions.spacingL),

              // Input section
              TextInputCard(controller: _textController, onSubmit: _onSubmit),

              const SizedBox(height: AppDimensions.spacingM),

              // Submit button
              SubmitButton(
                onPressed: _onSubmit,
                isLoading: widget.controller.isLoading,
              ),

              const SizedBox(height: AppDimensions.spacingL),

              // Result section
              SubmittedTextCard(
                text: widget.controller.hasSubmittedText
                    ? widget.controller.submittedText
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
