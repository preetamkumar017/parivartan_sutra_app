import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AppLoader extends StatelessWidget {
  final Color? color;
  final double size;
  final double strokeWidth;
  final bool fullScreen;
  final Color? overlayColor;

  const AppLoader({
    super.key,
    this.color,
    this.size = 40,
    this.strokeWidth = 3.5,
    this.fullScreen = true,
    this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    if (fullScreen) {
      return Container(
        color: overlayColor ?? AppColors.overlayLight,
        child: Center(
          child: _buildSpinner(),
        ),
      );
    }
    return Center(child: _buildSpinner());
  }

  Widget _buildSpinner() {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: color ?? AppColors.primary,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

// ─── Inline Loader (for buttons, small areas) ────────────────────────────────

class AppInlineLoader extends StatelessWidget {
  final Color? color;
  final double size;
  final double strokeWidth;

  const AppInlineLoader({
    super.key,
    this.color,
    this.size = 20,
    this.strokeWidth = 2.5,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: color ?? AppColors.white,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

// ─── Shimmer Placeholder ─────────────────────────────────────────────────────

class AppShimmerBox extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const AppShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  State<AppShimmerBox> createState() => _AppShimmerBoxState();
}

class _AppShimmerBoxState extends State<AppShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: Colors.grey.withValues(alpha: _animation.value),
          ),
        );
      },
    );
  }
}
