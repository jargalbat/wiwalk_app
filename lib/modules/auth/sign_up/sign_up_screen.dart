import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wiwalk_app/core/bloc/refresh_bloc.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/modules/auth/sign_up/page0_credentials/credentials_page.dart';
import 'package:wiwalk_app/modules/auth/sign_up/page1_phone/phone_page.dart';
import 'package:wiwalk_app/modules/auth/sign_up/page2_verify_phone/verify_phone_page.dart';
import 'package:wiwalk_app/modules/auth/sign_up/page3_email/email_page.dart';
import 'package:wiwalk_app/modules/auth/sign_up/page4_verify_email/verify_email_page.dart';
import 'package:wiwalk_app/modules/auth/sign_up/page5_user_info/user_info_page.dart';
import 'package:wiwalk_app/modules/auth/sign_up/page6_privacy_policy/privacy_policy_page.dart';
import 'package:wiwalk_app/widgets/c_scaffold.dart';
import 'sign_up_screen_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpScreenBloc(),
      child: const SignUpScreenBody(),
    );
  }
}

class SignUpScreenBody extends StatefulWidget {
  const SignUpScreenBody({super.key});

  @override
  State<SignUpScreenBody> createState() => _SignUpScreenBodyState();
}

class _SignUpScreenBodyState extends State<SignUpScreenBody> {
  // State
  SignUpScreenBloc get _signUpBloc => context.read<SignUpScreenBloc>();

  // PageView
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  final _pageMargin = const EdgeInsets.fromLTRB(
      CSize.spacing24, 60.0, CSize.spacing24, CSize.spacing24);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpScreenBloc, SignUpScreenState>(
          listener: _signUpListener,
        ),
        BlocListener<RefreshBloc, RefreshState>(
          listener: _refreshListener,
        ),
      ],
      child: BlocBuilder<SignUpScreenBloc, SignUpScreenState>(
        builder: (BuildContext context, SignUpScreenState state) {
          return CScaffold(
            onWillPop: () async {
              return Future.value(_onPressedBack());
            },
            // visibleAppBar: false,
            bodySafeArea: false,
            backgroundColor: Colors.white,
            body: GestureDetector(
              onTap: () {
                Func.hideKeyboard(context);
              },
              child: Column(
                children: [
                  SizedBox(height: context.mediaQueryPadding.top),

                  /// Indicator
                  _pageViewIndicator(),

                  /// Page view
                  Expanded(
                    child: _pageView(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _signUpListener(BuildContext context, SignUpScreenState state) {
    if (state is SignUpPrevPageState) {
      _goToPrevPage();
    } else if (state is SignUpNextPageState) {
      _goToNextPage();
    }
  }

  void _refreshListener(BuildContext context, RefreshState state) {
    // if (state is DanAuthSuccessState) {
    //   // todo
    //   print('DanAuthSuccessState');
    //   _goToNextPage();
    // }
  }

  Widget _pageViewIndicator() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
          CSize.spacing24, CSize.spacing24, CSize.spacing24, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _indicatorItem(true), // 0
          const SizedBox(width: 4.0),
          _indicatorItem(_pageIndex > 0), // 1
          const SizedBox(width: 4.0),
          _indicatorItem(_pageIndex > 1), // 2
          const SizedBox(width: 4.0),
          _indicatorItem(_pageIndex > 2), // 3
          const SizedBox(width: 4.0),
          _indicatorItem(_pageIndex > 3), // 4
          const SizedBox(width: 4.0),
          _indicatorItem(_pageIndex > 4), // 5
          const SizedBox(width: 4.0),
          _indicatorItem(_pageIndex > 5), // 6
        ],
      ),
    );
  }

  Widget _indicatorItem(bool isActive) {
    return Expanded(
      child: Container(
        height: 4.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          color: isActive
              ? context.theme.primaryColor
              : context.theme.dividerColor,
        ),
      ),
    );
  }

  Widget _pageView() {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        setState(() {
          _pageIndex = index;
          debugPrint('_pageIndex: $_pageIndex');
        });

        // _signUpBloc.add(SignUpChangePageEvent(index: index));
      },
      children: <Widget>[
        /// 0. Нэвтрэх нэр, нууц үг
        CredentialsPage(margin: _pageMargin),

        /// 1. Утасны дугаар оруулах
        PhonePage(margin: _pageMargin),

        /// 2. Утас баталгаажуулах
        VerifyPhonePage(margin: _pageMargin),

        /// 3. И-мэйл оруулах
        EmailPage(margin: _pageMargin),

        /// 4. И-мэйл баталгаажуулах
        VerifyEmailPage(margin: _pageMargin),

        /// 5. Хувийн мэдээлэл
        const UserInfoPage(),

        /// 6. Үйлчилгээний нөхцөл
        const PrivacyPolicyPage(),
      ],
    );
  }

  void _goToPrevPage() {
    if (_pageIndex == 0) {
      context.pop();
    } else if (_pageIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
    );
  }

  bool _onPressedBack() {
    if (_pageIndex == 0) {
      return true;
    } else if (_pageIndex > 0) {
      _goToPrevPage();
    }

    return false;
  }
}
