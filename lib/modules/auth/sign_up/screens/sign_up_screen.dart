import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wiwalk_app/core/bloc/refresh_bloc.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/modules/auth/sign_up/pages/page0_dan.dart';
import 'package:wiwalk_app/widgets/c_scaffold.dart';
import 'package:wiwalk_app/widgets/dialogs/custom_dialog.dart';
import '../pages/page1_credentials.dart';
import '../bloc/sign_up_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
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
  SignUpBloc get _signUpBloc => context.read<SignUpBloc>();

  // PageView
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  final _pageMargin = const EdgeInsets.fromLTRB(
      CSize.spacing24, 60.0, CSize.spacing24, CSize.spacing24);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpBloc, SignUpState>(
          listener: _signUpListener,
        ),
        BlocListener<RefreshBloc, RefreshState>(
          listener: _refreshListener,
        ),
      ],
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (BuildContext context, SignUpState state) {
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

  void _signUpListener(BuildContext context, SignUpState state) {
    if (state is SignUpPrevPageState) {
      _goToPrevPage();
    } else if (state is SignUpNextPageState) {
      _goToNextPage();
    } else if (state is SignUpSuccess) {
      _goToNextPage();
    } else if (state is SignUpFailed) {
      showCustomDialog(
        context,
        dialogType: DialogType.error,
        title: 'Амжилтгүй',
        text: state.message,
        button2Text: 'Ok',
      );
    }
  }

  void _refreshListener(BuildContext context, RefreshState state) {
    if (state is DanAuthSuccessState) {
      // todo
      print('DanAuthSuccessState');
      _goToNextPage();
    }
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
          const SizedBox(width: 4.0),
          _indicatorItem(_pageIndex > 6), // 7
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
          color:
              isActive ? context.theme.primaryColor : const Color(0xFFD3DFEB),
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
          print('_pageIndex: $_pageIndex');
        });

        // _signUpBloc.add(SignUpChangePageEvent(index: index));
      },
      children: <Widget>[
        /// ДАН
        Page0Dan(margin: _pageMargin),

        /// Нэвтрэх нэр, нууц үг
        Page1Credentials(margin: _pageMargin),

        /// Утасны дугаар, цахим шуудан
        Text('2'),

        /// Баталгаажуулах
        Text('3'),

        /// Гэрийн хаяг
        Text('4'),

        /// Хувийн мэдээлэл
        Text('5'),

        /// Гэрээ
        Text('6'),

        /// Амжилттай
        Text('7'),
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
