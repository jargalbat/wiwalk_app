import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/data/models/auth/email_code_request.dart';
import 'package:wiwalk_app/modules/auth/sign_up/page5_user_info/user_info_bloc.dart';
import 'package:wiwalk_app/modules/auth/sign_up/sign_up_screen_bloc.dart';
import 'package:wiwalk_app/widgets/dialogs/custom_dialog.dart';
import 'package:wiwalk_app/widgets/footer/c_footer.dart';
import 'package:wiwalk_app/widgets/text_field/c_text_field.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key, this.margin});

  final EdgeInsets? margin;

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  // State
  final _userInfoBloc = UserInfoBloc();

  SignUpScreenBloc get _signUpScreenBloc => context.read<SignUpScreenBloc>();

  // UI
  final double _screenMinHeight = 500.0;
  double _screenHeight = 0.0;

  // Phone
  final TextEditingController _weightController = TextEditingController();
  final FocusNode _weightFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      _weightController.text = 'jagaauser2@gmail.com';

      _userInfoBloc.add(ValidateEmailEvent(email: _weightController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _userInfoBloc,
      child: BlocListener<UserInfoBloc, UserInfoState>(
        listener: _listener,
        child: BlocBuilder<UserInfoBloc, UserInfoState>(
          builder: (BuildContext context, UserInfoState state) {
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
    if (state is GetEmailCodeSuccess) {
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
      controller: _weightController,
      focusNode: _weightFocus,
      title: 'Жин',
      labelText: 'Жин',
      keyboardType: TextInputType.number,
      prefixAsset: 'assets/images/auth/mail.svg',
      onChanged: (value) {
        _userInfoBloc.add(ValidateEmailEvent(email: _weightController.text));
      },
    );
  }

  Widget _footer(UserInfoState state) {
    return CFooter(
      button1Text: 'Буцах',
      onPressedButton1: () {
        _signUpScreenBloc.add(SignUpPrevPageEvent());
      },
      button2Text: 'Үргэлжлүүлэх',
      onPressedButton2: () {
        String? errorMessage;
        if (_weightController.text.isEmpty) {
          errorMessage = 'Жин оруулна уу.';
        } else if (_signUpScreenBloc.userId == null) {
          errorMessage =
              'Хэрэглэгчийн мэдээлэл олдсонгүй. Дахин бүртгүүлнэ үү!';
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
          email: _weightController.text,
        );

        _userInfoBloc.add(GetEmailCodeEvent(request: request));
      },
      loadingButton2: state is UserInfoLoadingState,
      button2Width: 180.0,
    );
  }
}
