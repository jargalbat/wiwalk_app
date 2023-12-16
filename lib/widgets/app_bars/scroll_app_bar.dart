import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/core/utils/func.dart';

class ScrollAppBar extends StatefulWidget {
  const ScrollAppBar({
    Key? key,
    this.scrollController,
    this.scrollExceedHeight,
    this.leading,
    this.customTitle,
    this.title,
    // this.actions,
    // this.action,
  }) : super(key: key);

  // Opacity
  final ScrollController? scrollController;
  final double? scrollExceedHeight;
  final Widget? leading;

  /// Custom title widget or title
  final Widget? customTitle;
  final String? title;

  // final List<Widget>? actions;
  // final Widget? action;

  @override
  State<ScrollAppBar> createState() => _ScrollAppBarState();
}

class _ScrollAppBarState extends State<ScrollAppBar> {
  // Box constraint
  double _height = CSize.statusBarHeight + kToolbarHeight;

  // Opacity
  ValueNotifier<double>? _opacityNotifier;
  final double _maxOpacity = 0.8;
  double? _scrollExceedHeight;

  @override
  void initState() {
    super.initState();

    _setScrollExceedHeight();

    if (widget.scrollController != null) {
      _opacityNotifier = ValueNotifier(0.0);
      widget.scrollController?.addListener(_scrollListener);
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = context.statusBarHeight + AppBar().preferredSize.height;
    _setScrollExceedHeight();

    if (_opacityNotifier != null) {
      return ValueListenableBuilder(
        valueListenable: _opacityNotifier!,
        builder: (BuildContext context2, double value, Widget? child) {
          if (value == 0.0) {
            return Container();
          } else {
            return SizedBox(
              height: _height,
              child: ClipRect(
                child: Opacity(
                  opacity: 1.0, //value,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                    child: Container(
                      width: double.infinity,
                      height: _height,
                      color: context.theme.colorScheme.background
                          .withOpacity(value),
                      child: SafeArea(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Leading button
                            widget.leading != null
                                ? widget.leading!
                                : Container(),

                            /// Title
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(
                                    CSize.spacing20, 0.0, CSize.spacing20, 0.0),
                                alignment: Alignment.center,
                                child: _titleWidget(),
                              ),
                            ),

                            /// Action button
                            widget.leading != null
                                ? Container(width: kToolbarHeight)
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      );
    } else {
      return Container();
    }
  }

  void _setScrollExceedHeight() {
    _scrollExceedHeight = widget.scrollExceedHeight ?? _height;
  }

  void _scrollListener() {
    var pixel = widget.scrollController?.position.pixels.floor() ?? 0.0;

    if (pixel <= 0) {
      _opacityNotifier?.value = 0.0;
    } else if (pixel <= _scrollExceedHeight!) {
      double newValue = pixel / _scrollExceedHeight!;

      if (newValue < 0.91) {
        // Don't show
        newValue = 0.0;
      } else {
        // Animate slowly
        newValue = (newValue - 0.9) * 10;
      }

      // Max value
      if (newValue > _maxOpacity) {
        newValue = _maxOpacity;
      }

      _opacityNotifier?.value = newValue;
    } else {
      _opacityNotifier?.value = _maxOpacity;
    }
  }

  Widget _titleWidget() {
    if (widget.customTitle != null) {
      /// Custom title widget
      return widget.customTitle!;
    } else {
      /// Title text
      return Text(
        widget.title ?? '',
        semanticsLabel: Func.toStr(widget.title),
        maxLines: 2,
        textAlign: TextAlign.center,
        style: context.textStyles.heading16?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      );
    }
  }
}
