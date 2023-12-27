import 'package:flutter/material.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'app_bars/c_app_bar.dart';
import 'background/image_background.dart';

class CScaffold extends StatelessWidget {
  const CScaffold({
    Key? key,
    this.scaffoldKey,
    this.onWillPop,
    this.backgroundAsset,
    this.backgroundColor,
    this.appBar,
    this.title,
    this.body,
    this.bodySafeArea = true,
    this.floatingActionButton,
    this.bottomNavigationBar,
  }) : super(key: key);

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final WillPopCallback? onWillPop;
  final String? backgroundAsset;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final String? title;
  final Widget? body;
  final bool bodySafeArea;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  bool get _visibleBackgroundAsset => backgroundAsset != null;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Stack(
        children: [
          /// Background
          if (_visibleBackgroundAsset) ImageBackground(asset: backgroundAsset!),

          /// Scaffold
          Scaffold(
            key: scaffoldKey,
            backgroundColor:
                _visibleBackgroundAsset ? Colors.transparent : backgroundColor,
            appBar: _appBar(context),
            body: _body(),
            floatingActionButton: floatingActionButton,
            bottomNavigationBar: bottomNavigationBar,
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget? _appBar(context) {
    if (appBar != null) {
      return appBar;
    } else if (title != null) {
      return CAppBar(context: context, title: title);
    } else {
      return null;
    }
  }

  Widget _body() {
    if (bodySafeArea) {
      return SafeArea(child: body ?? Container());
    } else {
      return body ?? Container();
    }
  }
}
