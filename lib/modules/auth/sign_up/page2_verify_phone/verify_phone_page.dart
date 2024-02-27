import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/data/models/auth/phone_code_request.dart';
import 'package:wiwalk_app/data/models/auth/verify_phone_request.dart';
import 'package:wiwalk_app/modules/auth/sign_up/sign_up_screen_bloc.dart';
import 'package:wiwalk_app/widgets/c_code_input.dart';
import 'package:wiwalk_app/widgets/dialogs/custom_dialog.dart';
import 'package:wiwalk_app/widgets/footer/c_footer.dart';
import 'package:wiwalk_app/widgets/text_field/c_text_field.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _verifyPhoneBloc,
      child: BlocListener<VerifyPhoneBloc, VerifyPhoneState>(
        listener: _listener,
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
                        /// Text
                        Container(
                          margin: widget.margin,
                          child: Column(
                            children: [
                              /// Phone
                              _codeInput(),
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

  void _listener(BuildContext context, state) {
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
      inputWidth: 20.0,
      controller: _codeController,
      focusNode: _codeFocus,
      length: 4,
      enablePinAutofill: true,
      onChanged: (value) {
        // if (value.length == 4) {
        _verifyPhoneBloc
            .add(ValidatePhoneCodeEvent(code: _codeController.text));
        // }

        // else {
        //   final request = VerifyPhoneRequest(
        //     userId: _signUpScreenBloc.userId,
        //     code: _codeController.text,
        //   );
        //
        //   _verifyPhoneBloc.add(VerifyPhone(request: request));
        // }
      },
      onCompleted: (v) {
        Func.hideKeyboard(context);

        final request = VerifyPhoneRequest(
          userId: _signUpScreenBloc.userId,
          code: _codeController.text,
        );

        _verifyPhoneBloc.add(VerifyPhone(request: request));
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

        final request = VerifyPhoneRequest(
          userId: _signUpScreenBloc.userId,
          code: _codeController.text,
        );

        _verifyPhoneBloc.add(VerifyPhone(request: request));
      },
      loadingButton2: state is VerifyPhoneLoadingState,
      button2Width: 180.0,
    );
  }
}
