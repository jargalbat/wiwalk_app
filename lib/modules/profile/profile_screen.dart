import 'package:flutter/material.dart';
import 'package:wiwalk_app/widgets/c_scaffold.dart';

import 'widgets/theme_switcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CScaffold(
      title: 'Профайл',
      bodySafeArea: true,
      body: Column(
        children: [
          const ThemeSwitcher(),
        ],
      ),
    );
  }
}
