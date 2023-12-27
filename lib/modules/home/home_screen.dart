import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/modules/home/screens/home_dashboard.dart';
import 'package:wiwalk_app/widgets/c_scaffold.dart';
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
      selectedLabelStyle: context.textStyles.body12?.copyWith(),
      unselectedLabelStyle: context.textStyles.body12?.copyWith(),
      items: <BottomNavigationBarItem>[
        /// Нүүр
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            _selectedIndex == 0
                ? 'assets/images/home/home_active.svg'
                : 'assets/images/home/home.svg',
            height: 34.0,
            fit: BoxFit.fitHeight,
          ),
          label: 'Нүүр',
        ),

        /// Челленж
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            _selectedIndex == 1
                ? 'assets/images/home/challenge_active.svg'
                : 'assets/images/home/challenge.svg',
            height: 34.0,
            fit: BoxFit.fitHeight,
          ),
          label: 'Челленж',
        ),

        /// Судалгаа
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            _selectedIndex == 2
                ? 'assets/images/home/survey_active.svg'
                : 'assets/images/home/survey.svg',
            height: 34.0,
            fit: BoxFit.fitHeight,
          ),
          label: 'Судалгаа',
        ),

        /// Мэдэгдэл
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            _selectedIndex == 3
                ? 'assets/images/home/notification_active.svg'
                : 'assets/images/home/notification.svg',
            height: 34.0,
            fit: BoxFit.fitHeight,
          ),
          label: 'Мэдэгдэл',
        ),
      ],
    );
  }
}
