import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/router/route_names.dart';
import 'package:wiwalk_app/core/theme/assets.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/widgets/buttons/button_settings.dart';
import 'package:wiwalk_app/widgets/buttons/c_text_button.dart';
import 'package:wiwalk_app/widgets/buttons/primary_button.dart';
import 'package:wiwalk_app/widgets/c_scaffold.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // UI
  final _horizontalPadding = const EdgeInsets.symmetric(horizontal: 32.0);

  // PageView
  final PageController _pageViewController = PageController();
  int _currentPageIndex = 0;
  final _pageViewHeight = 450.0;
  final _imageHeight = 350.0;

  @override
  Widget build(BuildContext context) {
    return CScaffold(
      onWillPop: () async {
        return Future.value(_onPressedBack());
      },
      // visibleAppBar: false,
      bodySafeArea: false,
      backgroundAsset: Assets.background2,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          /// Background
          _glowBackground(),

          Column(
            children: [
              const SizedBox(height: 170.0),

              /// PageView
              SizedBox(
                height: _pageViewHeight,
                child: PageView(
                  controller: _pageViewController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  children: <Widget>[
                    _page1(),
                    _page2(),
                    _page3(),
                  ],
                ),
              ),

              const SizedBox(height: 50.0),

              /// Indicator
              _pageViewIndicator(),

              /// Buttons
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: _horizontalPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Skip button
                      _skipButton(),

                      /// Next button
                      _nextButton(),
                    ],
                  ),
                ),
              ),

              /// Padding
              SizedBox(height: context.bottomPadding()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _glowBackground() {
    return Image.asset(
      Assets.glow,
      width: 400.0,
    );
  }

  Widget _pageViewIndicator() {
    return SmoothPageIndicator(
      controller: _pageViewController,
      count: 3,
      effect: ExpandingDotsEffect(
        dotHeight: 4.0,
        dotWidth: 8.0,
        activeDotColor: context.colors.text!,
      ),
    );
  }

  Widget _page1() {
    return AnimatedOpacity(
      opacity: _currentPageIndex == 0 ? 1 : 0,
      duration: Duration(milliseconds: _currentPageIndex == 0 ? 500 : 50),
      curve: Curves.easeIn,
      child: Column(
        children: [
          /// Image
          Container(
            height: _imageHeight,
            alignment: Alignment.topCenter,
            child: Image.asset(
              Assets.onboarding1,
              height: _imageHeight,
            ),
          ),

          const SizedBox(height: 50.0),

          /// Text
          _text('Түгжрэлийг хамтдаа давцгаая'),
        ],
      ),
    );
  }

  Widget _page2() {
    return AnimatedOpacity(
      opacity: _currentPageIndex == 1 ? 1 : 0,
      duration: Duration(milliseconds: _currentPageIndex == 1 ? 500 : 50),
      curve: Curves.easeIn,
      child: Column(
        children: [
          /// Image
          Container(
            height: _imageHeight,
            alignment: Alignment.topCenter,
            child: Image.asset(
              Assets.onboarding2,
              height: 300.0,
            ),
          ),

          const SizedBox(height: 50.0),

          /// Text
          _text('Мөнгө олж болох олон боломжууд'),
        ],
      ),
    );
  }

  Widget _page3() {
    return AnimatedOpacity(
      opacity: _currentPageIndex == 2 ? 1 : 0,
      duration: Duration(milliseconds: _currentPageIndex == 2 ? 500 : 50),
      curve: Curves.easeIn,
      child: Column(
        children: [
          /// Image
          Container(
            height: _imageHeight,
            alignment: Alignment.topCenter,
            child: Image.asset(
              Assets.onboarding3,
              height: 280.0,
            ),
          ),

          const SizedBox(height: 50.0),

          /// Text
          _text('Зөв амьдралын хэв маягийг суулгахад тань тусалъя'),
        ],
      ),
    );
  }

  Widget _text(String text) {
    return Container(
      padding: _horizontalPadding,
      alignment: Alignment.topLeft,
      child: Text(
        text.toUpperCase(),
        style: context.textStyles.bigTitle?.copyWith(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          height: 1.4,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _skipButton() {
    return CTextButton(
      onPressed: () {
        context.goNamed(RouteNames.login);
      },
      settings: ButtonSettings.large,
      text: 'Алгасах',
    );
  }

  Widget _nextButton() {
    return PrimaryButton(
      onPressed: () {
        if (_currentPageIndex == 2) {
          context.goNamed(RouteNames.login);
        } else {
          _pageViewController.nextPage(
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeInOut,
          );
        }
      },
      settings: ButtonSettings.large,
      text: 'Дараах',
      suffixIcon: Assets.arrowNext,
    );
  }

  bool _onPressedBack() {
    if (_currentPageIndex == 0) {
      return true;
    } else if (_currentPageIndex > 0) {
      _pageViewController.previousPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    }

    return false;
  }
}
