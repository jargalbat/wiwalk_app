import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/data/models/auth/sign_up_request.dart';
import 'package:wiwalk_app/modules/auth/sign_up/page0_credentials/credentials_bloc.dart';
import 'package:wiwalk_app/modules/auth/sign_up/sign_up_screen_bloc.dart';
import 'package:wiwalk_app/widgets/dialogs/custom_dialog.dart';
import 'package:wiwalk_app/widgets/footer/c_footer.dart';
import 'package:wiwalk_app/widgets/text_field/c_text_field.dart';

class CredentialsPage extends StatefulWidget {
  const CredentialsPage({super.key, this.margin});

  final EdgeInsets? margin;

  @override
  State<CredentialsPage> createState() => _CredentialsPageState();
}

class _CredentialsPageState extends State<CredentialsPage> {
  // State
  final _credentialsBloc = CredentialsBloc();

  SignUpScreenBloc get _signUpScreenBloc => context.read<SignUpScreenBloc>();

  // UI
  final double _screenMinHeight = 500.0;
  double _screenHeight = 0.0;

  // Username
  final TextEditingController _usernameController = TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  bool _isValidUsername = false;

  // Password
  final TextEditingController _password1Controller = TextEditingController();
  final FocusNode _password1Focus = FocusNode();
  final TextEditingController _password2Controller = TextEditingController();
  final FocusNode _password2Focus = FocusNode();
  final int _passwordLength = 8;

  bool get _isValidPassword => _isValid1 && _isValid2 && _isValid3 && _isValid4;
  bool _isValid1 = false;
  bool _isValid2 = false;
  bool _isValid3 = false;
  bool _isValid4 = false;

  // Button
  bool get _enabledNextButton => _isValidUsername && _isValidPassword;

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      _usernameController.text = 'jagaauser2@gmail.com';
      _password1Controller.text = 'Jagaapass';
      _password2Controller.text = 'Jagaapass';

      _credentialsBloc.add(
        CredentialsValidateUsernameEvent(username: _usernameController.text),
      );

      _credentialsBloc.add(
        CredentialsValidatePassEvent(
          pass1: _password1Controller.text,
          pass2: _password2Controller.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _credentialsBloc,
      child: BlocListener<CredentialsBloc, CredentialsState>(
        listener: _listener,
        child: BlocBuilder<CredentialsBloc, CredentialsState>(
          builder: (BuildContext context, CredentialsState state) {
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
                              /// Username
                              _usernameTextField(),

                              const SizedBox(height: CSize.spacing12),

                              /// Password 1
                              _password1TextField(),

                              const SizedBox(height: CSize.spacing8),

                              /// Password 2
                              _password2TextField(),

                              const SizedBox(height: CSize.spacing8),

                              /// Validation
                              _validationText(
                                _isValid1,
                                'Хамгийн багадаа $_passwordLength тэмдэгт байх',
                              ),
                              _validationText(
                                  _isValid2, 'Том үсэг орсон байх [A-Z]'),
                              _validationText(
                                  _isValid3, 'Жижиг үсэг орсон байх [a-z]'),
                              _validationText(
                                  _isValid4, 'Хоёр нууц үг ижил байх'),
                            ],
                          ),
                        ),

                        const Spacer(),

                        /// Footer
                        _footer(),
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
    if (state is CredentialsValidatePassState) {
      _isValid1 = state.isValid1;
      _isValid2 = state.isValid2;
      _isValid3 = state.isValid3;
      _isValid4 = state.isValid4;
    } else if (state is CredentialsValidateUsernameState) {
      _isValidUsername = state.isValidEmail || state.isValidPhone;
    } else if (state is SignUpSuccess) {
      _signUpScreenBloc.userId = state.response.userId;
      _signUpScreenBloc.add(SignUpNextPageEvent());
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

  Widget _usernameTextField() {
    return CTextField(
      controller: _usernameController,
      focusNode: _usernameFocus,
      title: 'Нэвтрэх нэр',
      labelText: 'Утасны дугаар/цахим шуудан оруулах',
      keyboardType: TextInputType.text,
      prefixAsset: 'assets/images/auth/user.svg',
      onChanged: (value) {
        _credentialsBloc.add(
          CredentialsValidateUsernameEvent(username: _usernameController.text),
        );
      },
    );
  }

  Widget _password1TextField() {
    return CTextField(
      controller: _password1Controller,
      focusNode: _password1Focus,
      prefixAsset: 'assets/images/auth/password.svg',
      title: 'Нууц үг',
      labelText: 'Нууц үг оруулах',
      obscureText: true,
      onChanged: (value) {
        _credentialsBloc.add(
          CredentialsValidatePassEvent(
            pass1: _password1Controller.text,
            pass2: _password2Controller.text,
          ),
        );
      },
    );
  }

  Widget _password2TextField() {
    return CTextField(
      controller: _password2Controller,
      focusNode: _password2Focus,
      prefixAsset: 'assets/images/auth/password.svg',
      labelText: 'Нууц үг давтан оруулах',
      obscureText: true,
      onChanged: (value) {
        _credentialsBloc.add(
          CredentialsValidatePassEvent(
            pass1: _password1Controller.text,
            pass2: _password2Controller.text,
          ),
        );
      },
    );
  }

  Widget _validationText(bool isValid, String text) {
    return Container(
      margin: const EdgeInsets.only(top: CSize.spacing8),
      child: Row(
        children: [
          /// Check
          SvgPicture.asset(
            'assets/images/core/check.svg',
            colorFilter: ColorFilter.mode(
              isValid ? context.theme.primaryColor : context.colors.icon2!,
              BlendMode.srcIn,
            ),
          ),

          const SizedBox(width: CSize.spacing10),

          /// Text
          Text(text, style: context.textStyles.body12),
        ],
      ),
    );
  }

  Widget _footer() {
    return BlocBuilder<SignUpScreenBloc, SignUpScreenState>(
      builder: (context, state) {
        return CFooter(
          button1Text: 'Буцах',
          onPressedButton1: () {
            _signUpScreenBloc.add(SignUpPrevPageEvent());
          },
          button2Text: 'Үргэлжлүүлэх',
          onPressedButton2: () {
            if (_enabledNextButton) {
              final request = SignUpRequest(
                userName: _usernameController.text,
                passCode: _password1Controller.text,
              );
              _credentialsBloc.add(SignUpEvent(request: request));
            } else {
              String warningText = 'Мэдээллээ зөв оруулна уу!';

              if (!_isValidUsername) {
                warningText = 'Нэвтрэх нэрээ зөв оруулна уу!';
              } else if (_isValidPassword) {
                warningText = 'Нууц үгээ зөв оруулна уу!';
              }

              showCustomDialog(
                context,
                dialogType: DialogType.warning,
                text: warningText,
                button2Text: 'Ok',
              );
            }
          },
          loadingButton2: state is CredentialsLoadingState,
          button2Width: 180.0,
        );
      },
    );
  }
}
