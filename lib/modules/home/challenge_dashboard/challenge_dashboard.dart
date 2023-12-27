import 'package:flutter/material.dart';

class ChallengeDashboard extends StatefulWidget {
  const ChallengeDashboard({super.key});

  @override
  State<ChallengeDashboard> createState() => _ChallengeDashboardState();
}

class _ChallengeDashboardState extends State<ChallengeDashboard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Divider(),

            const SizedBox(height: 10.0),

            // const SizedBox(width: 10.0),
          ],
        ),
      ),
    );
  }
}
