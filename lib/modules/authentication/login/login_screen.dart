import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wiwalk_app/core/router/route_names.dart';
import 'package:wiwalk_app/core/theme/assets.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/core/utils/shared_pref.dart';
import 'package:wiwalk_app/data/models/auth/login_request.dart';
import 'package:wiwalk_app/modules/authentication/auth_bloc.dart';
import 'package:wiwalk_app/widgets/buttons/button_settings.dart';
import 'package:wiwalk_app/widgets/buttons/c_text_button.dart';
import 'package:wiwalk_app/widgets/buttons/primary_button.dart';
import 'package:wiwalk_app/widgets/c_scaffold.dart';
import 'package:wiwalk_app/widgets/dialogs/custom_dialog.dart';
import 'package:wiwalk_app/widgets/text_field/c_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthBloc get _authBloc => context.read<AuthBloc>();

  bool _isSubmitting(AuthState state) => state is LoginLoadingState;

  // UI
  final double _screenMinHeight = 500.0;
  double _screenHeight = 0.0;

  // Username
  final TextEditingController _usernameController = TextEditingController();
  final FocusNode _usernameFocus = FocusNode();

  // Password
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();

  // Biometrics
  bool _isCheckedBiometrics = false;

  @override
  void initState() {
    _isCheckedBiometrics =
        sharedPref.getBool(SharedPrefKeys.biometricAuth) ?? false;

    if (kDebugMode) {
      _usernameController.text = '95770077';
      _passwordController.text = '1111';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CScaffold(
      backgroundColor: Colors.white,
      visibleAppBar: false,
      body: GestureDetector(
        onTap: () {
          Func.hideKeyboard(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: CSize.spacing24),
          child: Column(
            children: [
              const Spacer(),

              /// Logo
              Image.asset(
                Assets.logo,
                height: 70.0,
                width: 70.0,
              ),

              const SizedBox(height: 66.0),

              /// Username
              _usernameTextField(),

              const SizedBox(height: CSize.spacing8),

              /// Password
              _passwordTextField(),

              const SizedBox(height: CSize.spacing24),

              _biometricsCheckbox(),

              const SizedBox(height: CSize.spacing24),

              _loginButton(),

              const Spacer(),

              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CTextButton(
                    onPressed: () {
                      context.pushNamed(RouteNames.forgotPassword);
                    },
                    settings: ButtonSettings.large,
                    text: 'Нууц үг сэргээх',
                  ),

                  Container(
                    height: 20.0,
                    width: 1.0,
                    color: Color(0xFFC7D0D9),
                  ),
                  // VerticalDivider(
                  //   width: 20,
                  //   thickness: 1,
                  //   indent: 20,
                  //   endIndent: 0,
                  //   color: Colors.red,
                  // ),

                  CTextButton(
                    onPressed: () {
                      context.pushNamed(RouteNames.signUp);
                    },
                    settings: ButtonSettings.large,
                    text: 'Бүртгүүлэх',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _usernameTextField() {
    return CTextField(
      controller: _usernameController,
      focusNode: _usernameFocus,
      margin: const EdgeInsets.only(
          // bottom: CSize.spacing12,
          ),
      labelText: 'Нэвтрэх нэр',
      keyboardType: TextInputType.text,
      prefixAsset: Assets.user,
      onChanged: (value) {
        // _authBloc.add(
        //   TextChanged(_usernameController.text, 'username'),
        // );
      },
    );
  }

  Widget _passwordTextField() {
    return CTextField(
      controller: _passwordController,
      focusNode: _passwordFocus,
      prefixAsset: Assets.password,
      labelText: 'Нууц үг',
      obscureText: true,
      onChanged: (value) {
        // _authBloc.add(TextChanged(_passwordController.text, 'password'));
      },
    );
  }

  Widget _biometricsCheckbox() {
    return Row(
      children: [
        Checkbox(
          checkColor: Color(0xFF88939E),
          fillColor: MaterialStateProperty.resolveWith(getColor),
          // fillColor: MaterialStateProperty.resolveWith(Colors.white),
          // activeColor: Colors.red,
          value: _isCheckedBiometrics,
          side: MaterialStateBorderSide.resolveWith(
            (states) => BorderSide(width: 1.0, color: Color(0xFF88939E)),
          ),
          onChanged: (bool? value) {
            setState(() {
              _isCheckedBiometrics = value!;
            });
          },
        ),
        InkWell(
          onTap: () {
            setState(() {
              setState(() {
                _isCheckedBiometrics = !_isCheckedBiometrics;
              });
            });
          },
          borderRadius: BorderRadius.circular(8.0),
          child: Text(
            'Face ID ашиглан нэвтрэх',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _loginButton() {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is LoginSuccess) {
        } else if (state is LoginFailed) {
          showCustomDialog(
            context,
            child: CustomDialogBody(
              asset: 'assets/images/core/close.svg',
              title: 'Амжилтгүй',
              text: state.message,
            ),
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, AuthState state) {
          return PrimaryButton(
            onPressed: () {
              final loginRequest = LoginRequest(
                userName: _usernameController.text,
                passCode: _passwordController.text,
              );

              _authBloc.add(LoginEvent(request: loginRequest));
              // context.goNamed(RouteNames.home);
            },
            loading: state is LoginLoadingState,
            settings: ButtonSettings.large,
            text: 'Нэвтрэх',
          );
        },
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    return Colors.white;
    return const Color(0xFF88939E);

    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }

    return const Color(0xFF88939E);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }
}
