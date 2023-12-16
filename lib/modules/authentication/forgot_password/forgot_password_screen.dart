import 'package:flutter/material.dart';
import 'package:wiwalk_app/core/theme/assets.dart';
import 'package:wiwalk_app/modules/authentication/widgets/footer.dart';
import 'package:wiwalk_app/widgets/c_scaffold.dart';
import 'package:wiwalk_app/widgets/text_field/c_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // PageView
  final PageController _pageViewController = PageController();
  int _currentPageIndex = 0;

  // Phone
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();

  // Footer

  @override
  Widget build(BuildContext context) {
    return CScaffold(
      // visibleAppBar: false,
      title: 'Forgotpass',
      body: Column(
        children: [
          /// Indicator
          //

          /// PageView
          Expanded(
            child: PageView(
              controller: _pageViewController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              children: <Widget>[
                _page1(),
                _page2(),
                _page3(),
              ],
            ),
          ),

          Footer(
            child: Container(child: Text('hi')),
          )
        ],
      ),
    );
  }

  Widget _phoneTextField() {
    return CTextField(
      controller: _phoneController,
      focusNode: _phoneFocus,
      margin: const EdgeInsets.only(
          // bottom: CSize.spacing12,
          ),
      labelText: 'Нэвтрэх нэр',
      keyboardType: TextInputType.text,
      prefixAsset: Assets.phone,
      onChanged: (value) {
        // _authBloc.add(
        //   TextChanged(_usernameController.text, 'username'),
        // );
      },
    );
  }

  Widget _page1() {
    return Column(
      children: [
        _phoneTextField(),
      ],
    );
  }

  Widget _page2() {
    return Column(
      children: [
        _phoneTextField(),
      ],
    );
  }

  Widget _page3() {
    return Column(
      children: [
        _phoneTextField(),
      ],
    );
  }
}
