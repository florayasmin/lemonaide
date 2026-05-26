import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../data/mock/coach_intro_slides.dart';
import '../widgets/coach_chat_bar.dart';
import '../widgets/coach_story_widgets.dart';
import '../widgets/story_nav_button.dart';

class CoachScreen extends StatefulWidget {
  const CoachScreen({super.key});

  @override
  State<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> {
  final _chatController = TextEditingController();
  int _pageIndex = 0;

  List<String> get _slides => CoachIntroSlides.slides;

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  void _goPrevious() {
    if (_pageIndex > 0) {
      setState(() => _pageIndex--);
    }
  }

  void _goNext() {
    if (_pageIndex < _slides.length - 1) {
      setState(() => _pageIndex++);
    }
  }

  void _sendMessage() {
    final message = _chatController.text.trim();
    if (message.isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();
    _chatController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final padding = AppSpacing.screenPadding(context);
    final isFirstPage = _pageIndex == 0;
    final isLastPage = _pageIndex >= _slides.length - 1;

    return ColoredBox(
      color: AppColors.cream,
      child: Padding(
          padding: EdgeInsets.fromLTRB(
            padding,
            AppSpacing.md,
            padding,
            AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: StoryPagePanel(text: _slides[_pageIndex]),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StoryNavButton(
                    pointingRight: false,
                    enabled: !isFirstPage,
                    onPressed: isFirstPage ? null : _goPrevious,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  StoryNavButton(
                    pointingRight: true,
                    enabled: !isLastPage,
                    onPressed: isLastPage ? null : _goNext,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: CoachChatBar(
                      controller: _chatController,
                      onSend: _sendMessage,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
