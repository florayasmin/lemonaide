import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class RoundedInputField extends StatefulWidget {
  const RoundedInputField({
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.maxLines = 1,
    super.key,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final int maxLines;

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fill = isDark ? AppColors.darkSurfaceHigh : AppColors.creamSurface;
    final borderColor = _focused ? AppColors.blue : AppColors.border(isDark);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: AppTextStyles.inputLabel(context)),
          const SizedBox(height: AppSpacing.xs),
        ],
        Focus(
          onFocusChange: (v) => setState(() => _focused = v),
          child: AnimatedContainer(
            duration: AppSpacing.durationFast,
            decoration: BoxDecoration(
              borderRadius: AppSpacing.borderRadius(AppSpacing.radiusXl),
              boxShadow: _focused
                  ? [
                      BoxShadow(
                        color: AppColors.blue.withValues(alpha: 0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: TextFormField(
              controller: widget.controller,
              enabled: widget.enabled,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              validator: widget.validator,
              onChanged: widget.onChanged,
              maxLines: widget.maxLines,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: AppTextStyles.captionMuted(context),
                filled: true,
                fillColor: fill,
                prefixIcon: widget.prefixIcon != null
                    ? Icon(widget.prefixIcon, color: AppColors.blue)
                    : null,
                suffixIcon: widget.suffixIcon,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      AppSpacing.borderRadius(AppSpacing.radiusXl),
                  borderSide: BorderSide(color: borderColor, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      AppSpacing.borderRadius(AppSpacing.radiusXl),
                  borderSide: BorderSide(color: borderColor, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      AppSpacing.borderRadius(AppSpacing.radiusXl),
                  borderSide: const BorderSide(color: AppColors.blue, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius:
                      AppSpacing.borderRadius(AppSpacing.radiusXl),
                  borderSide: const BorderSide(color: AppColors.error, width: 2),
                ),
              ),
            ),
          ),
        ).animate().fadeIn(duration: 260.ms).slideY(begin: 0.04, end: 0),
      ],
    );
  }
}
