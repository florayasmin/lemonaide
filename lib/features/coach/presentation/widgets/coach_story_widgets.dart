import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/design_system/tokens/wireframe_styles.dart';
import '../../../../core/spacing/app_spacing.dart';
import 'typewriter_text.dart';

class StoryPagePanel extends StatelessWidget {
  const StoryPagePanel({
    required this.text,
    super.key,
  });

  final String text;

  static const _mascotSize = 124.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: WireframeStyles.boxDecoration(
        color: AppColors.skyBlue.withValues(alpha: 0.55),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            right: _mascotSize * 0.55,
            bottom: _mascotSize * 0.35,
            child: Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                child: TypewriterText(
                  key: ValueKey(text),
                  text: text,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.slate,
                        fontWeight: FontWeight.w700,
                        height: 1.45,
                        fontSize: 26,
                      ),
                ),
              ),
            ),
          ),
          const Positioned(
            right: 0,
            bottom: 0,
            child: _LeoMascot(size: _mascotSize),
          ),
        ],
      ),
    );
  }
}

class _LeoMascot extends StatelessWidget {
  const _LeoMascot({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.mascot,
      width: size,
      height: size,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.pets_rounded,
          size: size * 0.6,
          color: AppColors.slate,
        );
      },
    );
  }
}
