import 'dart:async';

import 'package:flutter/material.dart';

/// Reveals [text] one character at a time, like a storybook typewriter.
class TypewriterText extends StatefulWidget {
  const TypewriterText({
    required this.text,
    this.style,
    this.charDuration = const Duration(milliseconds: 28),
    super.key,
  });

  final String text;
  final TextStyle? style;
  final Duration charDuration;

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  Timer? _timer;
  int _visibleChars = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  @override
  void didUpdateWidget(TypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _restart();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _restart() {
    _timer?.cancel();
    _visibleChars = 0;
    _startTyping();
  }

  void _startTyping() {
    if (widget.text.isEmpty) {
      return;
    }

    _timer = Timer.periodic(widget.charDuration, (_) {
      if (!mounted) {
        return;
      }

      if (_visibleChars < widget.text.length) {
        setState(() => _visibleChars++);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final visible = widget.text.substring(0, _visibleChars.clamp(0, widget.text.length));

    return Text(
      visible,
      style: widget.style,
    );
  }
}
