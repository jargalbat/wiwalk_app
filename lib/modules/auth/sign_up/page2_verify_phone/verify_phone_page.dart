import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/data/models/auth/verify_phone_request.dart';
import 'package:wiwalk_app/modules/auth/sign_up/sign_up_screen_bloc.dart';
import 'package:wiwalk_app/widgets/c_code_input.dart';
import 'package:wiwalk_app/widgets/countdown/countdown_timer.dart';
import 'package:wiwalk_app/widgets/countdown/timer_bloc.dart';
import 'package:wiwalk_app/widgets/dialogs/custom_dialog.dart';
import 'package:wiwalk_app/widgets/footer/c_footer.dart';
import 'verify_phone_bloc.dart';

class VerifyPhonePage extends StatefulWidget {
  const VerifyPhonePage({super.key, this.margin});

  final EdgeInsets? margin;

  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  // State
  final _verifyPhoneBloc = VerifyPhoneBloc();
  final _timerBloc = TimerBloc(60);

  SignUpScreenBloc get _signUpScreenBloc => context.read<SignUpScreenBloc>();

  // UI
  final double _screenMinHeight = 500.0;
  double _screenHeight = 0.0;

  // Phone
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _codeFocus = FocusNode();
  bool _isValidCode = false;

  @override
  void initState() {
    super.initState();
  }

  // BlocProvider(
  // create: (context) => TimerBloc(60), // 60 seconds countdown
  // child: TimerPage(),
  // ),

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _verifyPhoneBloc),
        BlocProvider(create: (_) => _timerBloc..add(TimerStarted())),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<VerifyPhoneBloc, VerifyPhoneState>(
            listener: _verifyPhoneListener,
          ),
          // BlocListener<TimerBloc, TimerState>(
          //   listener: _refreshListener,
          // ),
        ],
        child: BlocBuilder<VerifyPhoneBloc, VerifyPhoneState>(
          builder: (BuildContext context, VerifyPhoneState state) {
            return LayoutBuilder(
              builder: (context, constraints) {
                // Height
                if (_screenHeight < constraints.maxHeight) {
                  _screenHeight = constraints.maxHeight;
                }
                if (_screenHeight < _screenMinHeight) {
                  _screenHeight = _screenMinHeight;
                }

                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: SizedBox(
                    height: _screenHeight,
                    child: Column(
                      children: [
                        Container(
                          margin: widget.margin,
                          child: Column(
                            children: [
                              /// Text
                              Text(
                                'Таны '
                                '(+976 ${Func.maskPhoneNumber(_signUpScreenBloc.phone)}) '
                                'дугаарт илгээсэн баталгаажуулах кодыг оруулна уу.',
                              ),

                              const SizedBox(height: CSize.spacing24),

                              /// Phone
                              _codeInput(),

                              const SizedBox(height: CSize.spacing32),

                              const CountdownTimer(),
                            ],
                          ),
                        ),

                        const Spacer(),

                        /// Footer
                        _footer(state),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _verifyPhoneListener(BuildContext context, state) {
    if (state is ValidatePhoneCodeState) {
      _isValidCode = state.isValidCode;
    } else if (state is VerifyPhoneSuccess) {
      _signUpScreenBloc.add(SignUpNextPageEvent());
    } else if (state is VerifyPhoneFailed) {
      showCustomDialog(
        context,
        dialogType: DialogType.error,
        title: 'Амжилтгүй',
        text: state.message,
        button2Text: 'Ok',
      );
    }
  }

  Widget _codeInput() {
    return CodeInputWidget(
      width: 56.0,
      controller: _codeController,
      focusNode: _codeFocus,
      length: 5,
      enablePinAutofill: true,
      onChanged: (value) {
        _verifyPhoneBloc.add(
          ValidatePhoneCodeEvent(
            code: _codeController.text,
          ),
        );
      },
      onCompleted: (v) {
        Func.hideKeyboard(context);

        _verifyPhone();
      },
    );
  }

  Widget _footer(VerifyPhoneState state) {
    return CFooter(
      button1Text: 'Буцах',
      onPressedButton1: () {
        _signUpScreenBloc.add(SignUpPrevPageEvent());
      },
      button2Text: 'Үргэлжлүүлэх',
      onPressedButton2: () {
        String? errorMessage;
        if (!_isValidCode) {
          errorMessage = 'Баталгаажуулах кодоо зөв оруулна уу!';
        } else if (_signUpScreenBloc.userId == null) {
          errorMessage =
              'Код баталгаажуулах хэрэглэгчийн мэдээлэл олдсонгүй. Дахин бүртгүүлнэ үү!';
        }

        if (errorMessage != null) {
          showCustomDialog(
            context,
            dialogType: DialogType.warning,
            text: errorMessage,
            button2Text: 'Ok',
          );
          return;
        }

        _verifyPhone();
      },
      loadingButton2: state is VerifyPhoneLoadingState,
      button2Width: 180.0,
    );
  }

  void _verifyPhone() {
    final request = VerifyPhoneRequest(
      userId: _signUpScreenBloc.userId,
      code: _codeController.text,
    );

    _verifyPhoneBloc.add(VerifyPhone(request: request));
  }
}
