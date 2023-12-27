import 'package:flutter/material.dart';

class SurveyDashboard extends StatefulWidget {
  const SurveyDashboard({super.key});

  @override
  State<SurveyDashboard> createState() => _SurveyDashboardState();
}

class _SurveyDashboardState extends State<SurveyDashboard> {
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
