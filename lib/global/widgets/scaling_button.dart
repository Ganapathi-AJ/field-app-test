import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScalingButton extends StatefulWidget {
  const ScalingButton({
    super.key,
    required this.child,
    this.onTap,
    this.scaleFactor = 0.98,
    this.hapticMediumImpact = true,
  });
  final double scaleFactor;

  final Widget child;

  final VoidCallback? onTap;

  final bool hapticMediumImpact;

  @override
  ScalingButtonState createState() => ScalingButtonState();
}

class ScalingButtonState extends State<ScalingButton> {
  double _scale = 1.0;
  late double _scaleFactor;
  final Duration _animationDuration = const Duration(milliseconds: 100);

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = _scaleFactor;
      if (widget.hapticMediumImpact) {
        HapticFeedback.mediumImpact();
      } else {
        HapticFeedback.heavyImpact();
      }
    });
  }

  Future<void> _onTapUp(TapUpDetails details) async {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  initState() {
    super.initState();
    _scaleFactor = widget.scaleFactor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTap: () {
        widget.onTap?.call();
      },
      onTapCancel: () {
        setState(() {
          _scale = 1.0;
        });
      },
      child: AnimatedScale(
        duration: _animationDuration,
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}
