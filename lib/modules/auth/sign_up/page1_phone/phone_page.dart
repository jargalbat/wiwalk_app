import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/data/models/auth/phone_code_request.dart';
import 'package:wiwalk_app/modules/auth/sign_up/sign_up_screen_bloc.dart';
import 'package:wiwalk_app/widgets/dialogs/custom_dialog.dart';
import 'package:wiwalk_app/widgets/footer/c_footer.dart';
import 'package:wiwalk_app/widgets/text_field/c_text_field.dart';
import 'phone_bloc.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key, this.margin});

  final EdgeInsets? margin;

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  // State
  final _phoneBloc = PhoneBloc();

  SignUpScreenBloc get _signUpScreenBloc => context.read<SignUpScreenBloc>();

  // UI
  final double _screenMinHeight = 500.0;
  double _screenHeight = 0.0;

  // Phone
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();
  bool _isValidPhone = false;

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      _phoneController.text = '90000002';
      // _phoneController.text = '12345678';

      _phoneBloc.add(ValidatePhoneEvent(phone: _phoneController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _phoneBloc,
      child: BlocListener<PhoneBloc, PhoneState>(
        listener: _listener,
        child: BlocBuilder<PhoneBloc, PhoneState>(
          builder: (BuildContext context, PhoneState state) {
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
                              _phoneTextField(),
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
    if (state is ValidatePhoneState) {
      _isValidPhone = state.isValidPhone;
    } else if (state is GetPhoneCodeSuccess) {
      _signUpScreenBloc.add(SignUpNextPageEvent());
    } else if (state is GetPhoneCodeFailed) {
      showCustomDialog(
        context,
        dialogType: DialogType.error,
        title: 'Амжилтгүй',
        text: state.message,
        button2Text: 'Ok',
      );
    }
  }

  Widget _phoneTextField() {
    return CTextField(
      controller: _phoneController,
      focusNode: _phoneFocus,
      title: 'Утасны дугаар',
      labelText: 'Баталгаажуулах код авах дугаар',
      keyboardType: TextInputType.text,
      prefixAsset: 'assets/images/auth/user.svg',
      onChanged: (value) {
        _phoneBloc.add(ValidatePhoneEvent(phone: _phoneController.text));
      },
    );
  }

  Widget _footer(PhoneState state) {
    return CFooter(
      button1Text: 'Буцах',
      onPressedButton1: () {
        _signUpScreenBloc.add(SignUpPrevPageEvent());
      },
      button2Text: 'Үргэлжлүүлэх',
      onPressedButton2: () {
        String? errorMessage;
        if (!_isValidPhone) {
          errorMessage = 'Утасны дугаараа зөв оруулна уу!';
        } else if (_signUpScreenBloc.userId == null) {
          errorMessage =
              'Утасны дугаар холбох хэрэглэгчийн мэдээлэл олдсонгүй. Дахин бүртгүүлнэ үү!';
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

        final request = PhoneCodeRequest(
          userId: _signUpScreenBloc.userId,
          phone: _phoneController.text,
        );

        _phoneBloc.add(GetPhoneCodeEvent(request: request));
      },
      loadingButton2: state is PhoneButtonLoadingState,
      button2Width: 180.0,
    );
  }
}
