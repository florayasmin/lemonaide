import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';
import '../tokens/wireframe_styles.dart';

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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: WireframeStyles.labelStyle(context)),
          const SizedBox(height: AppSpacing.xs),
        ],
        TextFormField(
          controller: widget.controller,
          enabled: widget.enabled,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          onChanged: widget.onChanged,
          maxLines: widget.maxLines,
          style: WireframeStyles.labelStyle(context),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: WireframeStyles.labelStyle(context).copyWith(
              color: AppColors.slate.withValues(alpha: 0.45),
            ),
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: AppColors.slate)
                : null,
            suffixIcon: widget.suffixIcon,
          ),
        ),
      ],
    );
  }
}
