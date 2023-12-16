import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wiwalk_app/core/bloc/refresh_bloc.dart';
import 'package:wiwalk_app/widgets/buttons/button_settings.dart';
import 'package:wiwalk_app/widgets/buttons/primary_button.dart';
import 'package:wiwalk_app/widgets/c_scaffold.dart';

class DanAuthScreen extends StatefulWidget {
  const DanAuthScreen({super.key});

  @override
  State<DanAuthScreen> createState() => _DanAuthScreenState();
}

class _DanAuthScreenState extends State<DanAuthScreen> {
  RefreshBloc get _refreshBloc => context.read<RefreshBloc>();

  @override
  Widget build(BuildContext context) {
    return CScaffold(
      title: 'ДАН',
      body: Column(
        children: [
          PrimaryButton(
            settings: ButtonSettings.large,
            onPressed: () {
              _refreshBloc.add(const DanAuthSuccessEvent(token: 'TestToken'));
              context.pop();
            },
            text: 'Success callback',
          ),
        ],
      ),
    );
  }
}
