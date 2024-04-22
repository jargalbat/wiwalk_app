import 'package:flutter/material.dart';

import '../../../core/theme/c_size.dart';

class NotificationDashboard extends StatefulWidget {
  const NotificationDashboard({super.key});

  @override
  State<NotificationDashboard> createState() => _NotificationDashboardState();
}

class _NotificationDashboardState extends State<NotificationDashboard> {
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
