import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_colors.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/core/utils/func.dart';

class CTextField extends StatefulWidget {
  const CTextField({
    Key? key,
    required this.controller,
    this.onChanged,
    this.focusNode,
    this.autofocus = false,
    this.readOnly = false,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.title,
    this.prefixAsset,
    this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.inputFormatter,
    this.fontSize = 15.0,
    this.textColor,
    this.maxLines,
    this.maxLength,
    this.errorText,
    this.reminderText,
    this.suffixIcon,
    this.suffixAsset,
  }) : super(key: key);

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool readOnly;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatter;
  final String? title;
  final String? prefixAsset;
  final String? labelText;
  final double fontSize;
  final Color? textColor;
  final Widget? suffixIcon;
  final String? suffixAsset;
  final String? errorText;
  final String? reminderText;

  @override
  _CTextFieldState createState() => _CTextFieldState();
}

class _CTextFieldState extends State<CTextField> {
  late FocusNode _focusNode;
  late bool _obscureText;
  bool _isTextFieldFocused = false;

  @override
  void initState() {
    super.initState();

    _focusNode = widget.focusNode ?? FocusNode();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
        children: [
          /// Title
          if (widget.title != null)
            Container(
              margin: const EdgeInsets.only(bottom: CSize.spacing16),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title ?? '',
                style: context.textStyles.body14?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          /// Text field
          Container(
            decoration: BoxDecoration(
              // color: context.theme.cardColor,
              // color: Colors.red,
              borderRadius: BorderRadius.circular(CSize.inputBorderRadius8),
              border: Border.all(color: _borderColor),
            ),
            child: Focus(
              onFocusChange: (hasFocus) {
                setState(() {
                  _isTextFieldFocused = hasFocus;
                });
              },
              child: TextField(
                onChanged: (value) {
                  if (widget.onChanged != null) {
                    widget.onChanged!(value);
                  }
                },
                controller: widget.controller ?? TextEditingController(),
                focusNode: _focusNode,
                inputFormatters: widget.inputFormatter,
                decoration: InputDecoration(
                  filled: true,
                  // fillColor: Colors.transparent,
                  // Set the background color to transparent.
                  border: InputBorder.none,
                  prefixIcon: _prefixIcon(),
                  labelText: widget.labelText,
                  // hintText: widget.labelText,
                  // hintStyle: TextStyle(
                  //     fontSize: widget.fontSize,
                  //     color: Theme.of(context).extension<MColors>()!.text3),
                  suffixIcon: _suffixIcon(),
                ),
                readOnly: widget.readOnly,
                maxLines: widget.maxLines ?? 1,
                autofocus: widget.autofocus,
                style: TextStyle(
                    color: Theme.of(context).extension<CColors>()!.text,
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.normal),
                keyboardType: widget.keyboardType,
                obscureText: _obscureText,
                maxLength: widget.maxLength,
              ),
            ),
          ),

          /// Error text
          if (_visibleErrorText)
            Container(
              margin: const EdgeInsets.only(top: CSize.spacing12),
              alignment: Alignment.topLeft,
              child: Text(
                Func.toStr(_errorText),
                style: const TextStyle(color: Colors.red),
              ),
            ),

          /// Reminder text
          if (_visibleReminderText)
            Container(
              margin: const EdgeInsets.only(top: CSize.spacing12),
              alignment: Alignment.topLeft,
              child: Text(
                _reminderText ?? '',
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }

  String? get _errorText => widget.errorText;

  bool get _visibleErrorText => Func.isNotEmpty(_errorText);

  String? get _reminderText => widget.reminderText;

  bool get _visibleReminderText => Func.isNotEmpty(_reminderText);

  Color get _borderColor => _reminderText != null
      ? Colors.orange
      : _errorText != null
          ? Colors.red
          : _isTextFieldFocused
              ? Theme.of(context).primaryColor
              : Colors.transparent;

  Widget? _prefixIcon() {
    return (widget.prefixAsset != null)
        ? SvgPicture.asset(
            widget.prefixAsset!,
            fit: BoxFit.scaleDown,
            color: Theme.of(context).primaryColor,
          )
        : null;
  }

  Widget _obscureButton() {
    return InkWell(
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: CSize.spacing12),
        height: 20.0,
        width: 20.0,
        child: SvgPicture.asset(
          _obscureText
              ? 'assets/images/core/hide.svg'
              : 'assets/images/core/show.svg',
          fit: BoxFit.scaleDown,
          color: Theme.of(context).primaryColor,
          height: 20.0,
          width: 20.0,
        ),
      ),
    );
  }

  Widget? _suffixIcon() {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }

    if (_focusNode.hasFocus && (widget.maxLines ?? 1) == 1) {
      // Focused
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [if (widget.obscureText) _obscureButton()],
      );
    } else if (widget.suffixAsset != null) {
      // Unfocused
      return SvgPicture.asset(
        widget.suffixAsset!,
        fit: BoxFit.scaleDown,
        color: Theme.of(context).primaryColor,
      );
    } else {
      return null;
    }
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

// Widget _clearButton() {
//   return InkWell(
//     onTap: () {
//       // widget.controller.clear();
//     },
//     child: Container(
//       margin: EdgeInsets.only(right: 12.0),
//       height: 20.0,
//       width: 20.0,
//       decoration: BoxDecoration(
//           shape: BoxShape.circle, color: Theme.of(context).primaryColor),
//       child: SvgPicture.asset(
//         "assets/icons/clear.svg",
//         fit: BoxFit.scaleDown,
//         color: Theme.of(widget.context).cardColor,
//       ),
//     ),
//   );
// }
