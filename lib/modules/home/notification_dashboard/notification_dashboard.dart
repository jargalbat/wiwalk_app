import 'package:flutter/material.dart';

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
            const Divider(),

            const SizedBox(height: 10.0),

            // const SizedBox(width: 10.0),
          ],
        ),
      ),
    );
  }
}
