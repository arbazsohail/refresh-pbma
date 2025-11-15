import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final String text;
  final String? initialText;
  final Function(String value)? onChange;
  final Widget? prefix;
  final TextInputType? textInputType;
  final Function()? prefixIconTap;
  final bool? obsecureText;
  final bool showPasswordToggle; // <-- NEW: whether to show eye icon
  final bool? readOnly;
  final bool? enabled; // <-- NEW: whether field is enabled
  final Color? borderColor;
  final double? borderSideWidth;
  final int? maxLines;
  final double? contentPadding;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputAction? textInputAction;
  final bool? autofocus;
  final Color? filledColor;
  final double? borderRadius;

  const CustomTextfield({
    super.key,
    this.controller,
    this.validation,
    this.textInputType,
    this.prefixIconTap,
    required this.text,
    this.obsecureText,
    this.prefix,
    this.onChange,
    this.initialText,
    this.borderColor,
    this.borderSideWidth,
    this.maxLines,
    this.contentPadding,
    this.inputFormatter,
    this.textInputAction,
    this.readOnly,
    this.enabled, // <-- NEW parameter
    this.autofocus,
    this.filledColor,
    this.showPasswordToggle = false, // <-- default to false
    this.borderRadius = 12, // <-- default to 12
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = widget.obsecureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.enabled ?? true;

    return Container(
      decoration: BoxDecoration(
        color: widget.filledColor ?? AppColors.surface,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
      ),
      child: TextFormField(
        style: TextStyle(
          fontSize: 16,
          color: isEnabled ? AppColors.blackText : AppColors.greyText,
        ),
        enabled: isEnabled,
        autofocus: widget.autofocus ?? false,
        inputFormatters: widget.inputFormatter,
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        readOnly: widget.readOnly ?? false,
        validator: widget.validation,
        controller: widget.controller,
        onChanged: widget.onChange,
        obscureText: isObscure,
        initialValue: widget.initialText,
        maxLines: widget.maxLines ?? 1,
        cursorColor: AppColors.primary,
        textDirection: TextDirection.ltr,
        decoration: InputDecoration(
          hintText: widget.text,
          hintStyle: TextStyle(
            fontSize: 16,
            color: AppColors.textHint,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: widget.contentPadding ?? 16,
            horizontal: 16,
          ),
          prefixIcon: widget.prefix != null
              ? (widget.maxLines != null && widget.maxLines! > 1
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, left: 12, right: 8),
                        child: IconTheme(
                          data: IconThemeData(
                            color: AppColors.textSecondary,
                          ),
                          child: widget.prefix!,
                        ),
                      ),
                    )
                  : IconTheme(
                      data: IconThemeData(
                        color: AppColors.textSecondary,
                      ),
                      child: widget.prefix!,
                    ))
              : null,
          prefixIconConstraints: widget.maxLines != null && widget.maxLines! > 1
              ? const BoxConstraints(
                  minWidth: 48,
                )
              : null,
          suffixIcon: widget.showPasswordToggle
              ? IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                )
              : null,
          filled: false,
          border: widget.borderColor != null
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.borderColor!,
                    width: widget.borderSideWidth ?? 1,
                  ),
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
                )
              : InputBorder.none,
          focusedBorder: widget.borderColor != null
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.secondary,
                    width: widget.borderSideWidth ?? 1,
                  ),
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
                )
              : InputBorder.none,
          enabledBorder: widget.borderColor != null
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.borderColor!,
                    width: widget.borderSideWidth ?? 1,
                  ),
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
                )
              : InputBorder.none,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.error,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.error,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          ),
        ),
      ),
    );
  }
}
