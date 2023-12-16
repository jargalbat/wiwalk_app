import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wiwalk_app/core/router/route_names.dart';
import 'package:wiwalk_app/modules/auth/sign_up/sign_up_bloc.dart';
import 'package:wiwalk_app/widgets/footer/c_footer.dart';

class Page0Dan extends StatefulWidget {
  const Page0Dan({super.key, this.margin});

  final EdgeInsets? margin;

  @override
  State<Page0Dan> createState() => _Page0DanState();
}

class _Page0DanState extends State<Page0Dan> {
  SignUpBloc get _signUpBloc => context.read<SignUpBloc>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Text
        Expanded(
          child: Container(
            margin: widget.margin,
            child: const Text(
              'ДАН танилт нэвтрэлтийн нэгдсэн системд хандах шаардлагатай.',
            ),
          ),
        ),

        //
        _footer(),
      ],
    );
  }

  Widget _footer() {
    return CFooter(
      button1Text: 'Буцах',
      onPressedButton1: () {
        _signUpBloc.add(SignUpPrevPageEvent());
      },
      button2Text: 'ДАН-аар нэвтрэх',
      onPressedButton2: () {
        context.pushNamed(RouteNames.danAuth);
      },
    );
  }
}
