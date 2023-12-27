import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/router/custom_router.dart';
import 'package:wiwalk_app/core/router/route_names.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/modules/challenge/challenge_screen/pedometer/pedometer_page.dart';
import 'package:wiwalk_app/modules/home/screens/home_dashboard.dart';
import 'package:wiwalk_app/widgets/background/image_background.dart';
import 'package:wiwalk_app/widgets/c_scaffold.dart';
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
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CScaffold(
      appBar: _appBar(),
      backgroundAsset: 'assets/images/core/background.png',
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Row(
        children: [
          SizedBox(width: CSize.spacing8),
          ProfilePicture(),
          SizedBox(width: CSize.spacing8),
          Text('Hi,'),
        ],
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _body() {
    switch (_selectedIndex) {
      case 0:
        return const HomeDashboard();
      case 1:
        return Container();
      case 2:
        return Container();
      case 3:
        return Container();
      default:
        return Container();
    }
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      selectedLabelStyle: context.textStyles.body12?.copyWith(
        // color: context.colors.text2,
      ),
      unselectedLabelStyle: context.textStyles.body12?.copyWith(
        // color: context.colors.text2,
      ),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/home/${_selectedIndex == 0 ? 'home_active.svg' : 'home.svg'}',
            height: 34.0,
            fit: BoxFit.fitHeight,
          ),
          label: 'Нүүр',
          // backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/home/${_selectedIndex == 1 ? 'challenge_active.svg' : 'challenge.svg'}',
            height: 34.0,
            fit: BoxFit.fitHeight,
          ),
          label: 'Челленж',
          // backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/home/${_selectedIndex == 2 ? 'survey_active.svg' : 'survey.svg'}',
            height: 34.0,
            fit: BoxFit.fitHeight,
          ),
          label: 'Судалгаа',
          // backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/home/${_selectedIndex == 3 ? 'notification_active.svg' : 'notification.svg'}',
            height: 34.0,
            fit: BoxFit.fitHeight,
          ),
          label: 'Мэдэгдэл',
          // backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
