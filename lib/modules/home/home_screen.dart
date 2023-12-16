import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/router/custom_router.dart';
import 'package:wiwalk_app/core/router/route_names.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/modules/challenge/challenge_screen/pedometer/pedometer_page.dart';
import 'package:wiwalk_app/widgets/background/image_background.dart';
import '../../core/theme/assets.dart';
import '../challenge/challenge_screen/map/map_sample.dart';
import '../challenge/challenge_screen/map/order_tracking/order_tracking_page.dart';
import '../challenge/challenge_screen/map/polyline_page.dart';
import 'widgets/challenge_today/challenge_today.dart';
import 'widgets/profile_picture.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background
        if (!context.isDarkMode) const ImageBackground(),

        /// Body
        Scaffold(
          appBar: AppBar(
            title: const Row(
              children: [
                SizedBox(width: CSize.spacing8),
                ProfilePicture(),
                SizedBox(width: CSize.spacing8),
                Text('Hi,'),
              ],
            ),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
          ),
        ),
      ],
    );
  }
}
