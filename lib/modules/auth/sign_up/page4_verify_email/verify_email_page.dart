import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/data/models/auth/verify_email_request.dart';
import 'package:wiwalk_app/data/models/auth/verify_phone_request.dart';
import 'package:wiwalk_app/modules/auth/sign_up/sign_up_screen_bloc.dart';
import 'package:wiwalk_app/widgets/c_code_input.dart';
import 'package:wiwalk_app/widgets/countdown/countdown_timer.dart';
import 'package:wiwalk_app/widgets/countdown/timer_bloc.dart';
import 'package:wiwalk_app/widgets/dialogs/custom_dialog.dart';
import 'package:wiwalk_app/widgets/footer/c_footer.dart';

import 'verify_email_bloc.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key, this.margin});

  final EdgeInsets? margin;

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  // State
  final _verifyEmailBloc = VerifyEmailBloc();
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
        BlocProvider(create: (_) => _verifyEmailBloc),
        BlocProvider(create: (_) => _timerBloc..add(TimerStarted())),
      ],
      child: BlocListener<VerifyEmailBloc, VerifyEmailState>(
        listener: _verifyPhoneListener,
        child: BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
          builder: (BuildContext context, VerifyEmailState state) {
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
                                'Таны (${Func.maskEmail(_signUpScreenBloc.email)}) '
                                'цахим шууданд илгээсэн баталгаажуулах кодыг оруулна уу',
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
    if (state is ValidateEmailCodeState) {
      _isValidCode = state.isValidCode;
    } else if (state is VerifyEmailSuccess) {
      _signUpScreenBloc.add(SignUpNextPageEvent());
    } else if (state is VerifyEmailFailed) {
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
        _verifyEmailBloc
            .add(ValidateEmailCodeEvent(code: _codeController.text));
      },
      onCompleted: (v) {
        Func.hideKeyboard(context);
        _verifyEmail();
      },
    );
  }

  Widget _footer(VerifyEmailState state) {
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

        _verifyEmail();
      },
      loadingButton2: state is VerifyEmailLoadingState,
      button2Width: 180.0,
    );
  }

  void _verifyEmail() {
    final request = VerifyEmailRequest(
      userId: _signUpScreenBloc.userId,
      code: _codeController.text,
    );

    _verifyEmailBloc.add(VerifyEmail(request: request));
  }
}
