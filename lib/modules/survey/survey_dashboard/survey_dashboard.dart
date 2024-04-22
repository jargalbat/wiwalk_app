import 'package:flutter/material.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';

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

            const SizedBox(height: CSize.spacing24),

            // const SizedBox(width: 10.0),
          ],
        ),
      ),
    );
  }
}
