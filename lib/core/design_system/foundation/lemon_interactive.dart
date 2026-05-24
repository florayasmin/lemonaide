import 'package:flutter/material.dart';

import '../tokens/app_motion.dart';

/// Hover (desktop/web) + bounce tap wrapper for playful interactions.
class LemonInteractive extends StatefulWidget {
  const LemonInteractive({
    required this.child,
    this.onTap,
    this.enabled = true,
    this.enableHover = true,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool enabled;
  final bool enableHover;

  @override
  State<LemonInteractive> createState() => _LemonInteractiveState();
}

class _LemonInteractiveState extends State<LemonInteractive> {
  bool _hovered = false;
  bool _pressed = false;

  bool get _active => widget.enabled && widget.onTap != null;

  Future<void> _handleTap() async {
    if (!_active) return;
    setState(() => _pressed = true);
    await Future<void>.delayed(AppMotion.instant);
    if (!mounted) return;
    setState(() => _pressed = false);
    widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    final scale = !_active
        ? 1.0
        : _pressed
            ? AppMotion.tapScale
            : _hovered && widget.enableHover
                ? AppMotion.hoverScale
                : 1.0;

    return MouseRegion(
      onEnter: widget.enableHover && _active
          ? (_) => setState(() => _hovered = true)
          : null,
      onExit: widget.enableHover && _active
          ? (_) => setState(() => _hovered = false)
          : null,
      child: GestureDetector(
        onTapDown: _active ? (_) => setState(() => _pressed = true) : null,
        onTapUp: _active ? (_) => setState(() => _pressed = false) : null,
        onTapCancel: _active ? () => setState(() => _pressed = false) : null,
        onTap: _active ? _handleTap : null,
        behavior: HitTestBehavior.opaque,
        child: AnimatedScale(
          scale: scale,
          duration: AppMotion.fast,
          curve: AppMotion.playful,
          child: AnimatedOpacity(
            opacity: _active ? 1 : 0.55,
            duration: AppMotion.fast,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
