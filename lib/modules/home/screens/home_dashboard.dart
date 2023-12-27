import 'package:flutter/material.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/modules/challenge/challenge_screen/map/map_sample.dart';
import 'package:wiwalk_app/modules/challenge/challenge_screen/map/order_tracking/order_tracking_page.dart';
import 'package:wiwalk_app/modules/challenge/challenge_screen/map/polyline_page.dart';
import 'package:wiwalk_app/modules/challenge/challenge_screen/pedometer/pedometer_page.dart';
import 'package:wiwalk_app/modules/home/widgets/challenge_today/challenge_today.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Divider(),

            const SizedBox(height: 10.0),

            /// Өнөөдрийн чэлленж
            const ChallengeToday(
              margin: EdgeInsets.symmetric(horizontal: CSize.spacing24),
            ),

            const SizedBox(height: 20.0),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const PedometerPage(),
                  ),
                );
              },
              child: const Text('Pedometer page'),
            ),

            const SizedBox(height: 20.0),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const MapSample(),
                  ),
                );
              },
              child: const Text('Map page'),
            ),

            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const OrderTrackingPage(),
                  ),
                );
              },
              child: const Text('Order tracking page'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const PolylinePage(),
                  ),
                );
              },
              child: const Text('Polyline map page'),
            ),

            // const SizedBox(width: 10.0),
          ],
        ),
      ),
    );
  }
}
