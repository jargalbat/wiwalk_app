import 'package:flutter/material.dart';
import 'package:wiwalk_app/widgets/c_scaffold.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key, required this.challengeId});

  final String challengeId;

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  @override
  Widget build(BuildContext context) {
    return CScaffold(
      title: 'Чэлленж',
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Challenge id ${widget.challengeId}'),
            // Container(
            //   height: 1000.0,
            //   width: 200.0,
            //   color: Colors.red,
            // ),
            // Text('123'),
          ],
        ),
      ),
      floatingActionButton: Container(
        // color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
