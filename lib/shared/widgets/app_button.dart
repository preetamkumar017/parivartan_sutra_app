import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'app_loader.dart';

enum AppButtonType { primary, secondary, outlined, text, danger }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isLoading;
  final bool isDisabled;
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsets? padding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.height = 52,
    this.borderRadius = 12,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
  });

  bool get _isEnabled => !isDisabled && !isLoading && onPressed != null;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AppButtonType.primary:
        return _buildElevatedButton(context);
      case AppButtonType.secondary:
        return _buildSecondaryButton(context);
      case AppButtonType.outlined:
        return _buildOutlinedButton(context);
      case AppButtonType.text:
        return _buildTextButton(context);
      case AppButtonType.danger:
        return _buildDangerButton(context);
    }
  }

  Widget _buildElevatedButton(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: _isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ??
              (_isEnabled ? AppColors.buttonPrimary : AppColors.buttonDisabled),
          foregroundColor: foregroundColor ?? AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
          elevation: 0,
        ),
        child: _buildChild(AppColors.white),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: _isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ??
              (_isEnabled ? AppColors.secondary : AppColors.buttonDisabled),
          foregroundColor: foregroundColor ?? AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
          elevation: 0,
        ),
        child: _buildChild(AppColors.white),
      ),
    );
  }

  Widget _buildOutlinedButton(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: _isEnabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor ??
              (_isEnabled ? AppColors.primary : AppColors.buttonDisabled),
          side: BorderSide(
            color: _isEnabled ? AppColors.primary : AppColors.buttonDisabled,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
        ),
        child: _buildChild(
          _isEnabled ? AppColors.primary : AppColors.buttonDisabled,
        ),
      ),
    );
  }

  Widget _buildTextButton(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: _isEnabled ? onPressed : null,
        style: TextButton.styleFrom(
          foregroundColor: foregroundColor ??
              (_isEnabled ? AppColors.primary : AppColors.buttonDisabled),
          padding: padding,
        ),
        child: _buildChild(
          _isEnabled ? AppColors.primary : AppColors.buttonDisabled,
        ),
      ),
    );
  }

  Widget _buildDangerButton(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: _isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ??
              (_isEnabled ? AppColors.error : AppColors.buttonDisabled),
          foregroundColor: foregroundColor ?? AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
          elevation: 0,
        ),
        child: _buildChild(AppColors.white),
      ),
    );
  }

  Widget _buildChild(Color loaderColor) {
    if (isLoading) {
      return AppInlineLoader(color: loaderColor);
    }

    if (prefixIcon != null || suffixIcon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prefixIcon != null) ...[
            prefixIcon!,
            const SizedBox(width: 8),
          ],
          Text(label, style: textStyle ?? AppTextStyles.button),
          if (suffixIcon != null) ...[
            const SizedBox(width: 8),
            suffixIcon!,
          ],
        ],
      );
    }

    return Text(label, style: textStyle ?? AppTextStyles.button);
  }
}

// ─── Icon Button ─────────────────────────────────────────────────────────────

class AppIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final double borderRadius;
  final bool isLoading;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size = 48,
    this.borderRadius = 12,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: backgroundColor ?? AppColors.primary,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: isLoading
                ? AppInlineLoader(size: size * 0.4)
                : icon,
          ),
        ),
      ),
    );
  }
}
