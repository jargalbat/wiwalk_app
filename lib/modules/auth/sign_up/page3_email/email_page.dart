import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/data/models/auth/email_code_request.dart';
import 'package:wiwalk_app/modules/auth/sign_up/sign_up_screen_bloc.dart';
import 'package:wiwalk_app/widgets/dialogs/custom_dialog.dart';
import 'package:wiwalk_app/widgets/footer/c_footer.dart';
import 'package:wiwalk_app/widgets/text_field/c_text_field.dart';
import 'email_bloc.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key, this.margin});

  final EdgeInsets? margin;

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  // State
  final _emailBloc = EmailBloc();

  SignUpScreenBloc get _signUpScreenBloc => context.read<SignUpScreenBloc>();

  // UI
  final double _screenMinHeight = 500.0;
  double _screenHeight = 0.0;

  // Phone
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  bool _isValidEmail = false;

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      _emailController.text = 'jagaauser2@gmail.com';

      _emailBloc.add(ValidateEmailEvent(email: _emailController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _emailBloc,
      child: BlocListener<EmailBloc, EmailState>(
        listener: _listener,
        child: BlocBuilder<EmailBloc, EmailState>(
          builder: (BuildContext context, EmailState state) {
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
                              /// Email
                              _emailTextField(),
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
    if (state is ValidateEmailState) {
      _isValidEmail = state.isValidEmail;
    } else if (state is GetEmailCodeSuccess) {
      _signUpScreenBloc.email = state.email;
      _signUpScreenBloc.add(SignUpNextPageEvent());
    } else if (state is GetEmailCodeFailed) {
      showCustomDialog(
        context,
        dialogType: DialogType.error,
        title: 'Амжилтгүй',
        text: state.message,
        button2Text: 'Ok',
      );
    }
  }

  Widget _emailTextField() {
    return CTextField(
      controller: _emailController,
      focusNode: _emailFocus,
      title: 'Цахим шуудан',
      labelText: 'Баталгаажуулах код авах цахим шуудан',
      keyboardType: TextInputType.text,
      prefixAsset: 'assets/images/auth/mail.svg',
      onChanged: (value) {
        _emailBloc.add(ValidateEmailEvent(email: _emailController.text));
      },
    );
  }

  Widget _footer(EmailState state) {
    return CFooter(
      button1Text: 'Буцах',
      onPressedButton1: () {
        _signUpScreenBloc.add(SignUpPrevPageEvent());
      },
      button2Text: 'Үргэлжлүүлэх',
      onPressedButton2: () {
        String? errorMessage;
        if (!_isValidEmail) {
          errorMessage = 'И-мэйл хаягаа зөв оруулна уу.';
        } else if (_signUpScreenBloc.userId == null) {
          errorMessage =
              'И-мэйл холбох хэрэглэгчийн мэдээлэл олдсонгүй. Дахин бүртгүүлнэ үү!';
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

        final request = EmailCodeRequest(
          userId: _signUpScreenBloc.userId,
          email: _emailController.text,
        );

        _emailBloc.add(GetEmailCodeEvent(request: request));
      },
      loadingButton2: state is EmailLoadingState,
      button2Width: 180.0,
    );
  }
}
