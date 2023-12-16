import 'package:flutter/material.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'app_bars/c_app_bar.dart';
import 'background/image_background.dart';

class CScaffold extends StatelessWidget {
  const CScaffold({
    Key? key,
    this.scaffoldKey,
    this.onWillPop,
    this.visibleAppBar = true,
    this.backgroundAsset,
    this.backgroundColor,
    this.title,
    this.body,
    this.bodySafeArea = true,
    this.floatingActionButton,
  }) : super(key: key);

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final WillPopCallback? onWillPop;
  final bool visibleAppBar;
  final String? backgroundAsset;
  final Color? backgroundColor;
  final String? title;
  final Widget? body;
  final bool bodySafeArea;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    bool visibleBackgroundAsset =
        backgroundAsset != null && !context.isDarkMode;

    return WillPopScope(
      onWillPop: onWillPop,
      child: Stack(
        children: [
          /// Background
          if (visibleBackgroundAsset) ImageBackground(asset: backgroundAsset!),

          /// Scaffold
          Scaffold(
            key: scaffoldKey,
            backgroundColor: !visibleBackgroundAsset ? backgroundColor : null,
            appBar:
                visibleAppBar ? CAppBar(context: context, title: title) : null,
            body: _body(),
            floatingActionButton: floatingActionButton,
          ),
        ],
      ),
    );
  }

  Widget _body() {
    if (bodySafeArea) {
      return SafeArea(child: body ?? Container());
    } else {
      return body ?? Container();
    }
  }
}
