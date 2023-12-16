import 'package:flutter/material.dart';
import 'package:wiwalk_app/widgets/c_scaffold.dart';

class ChallengeDetailScreen extends StatefulWidget {
  const ChallengeDetailScreen({super.key});

  @override
  State<ChallengeDetailScreen> createState() => _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends State<ChallengeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return CScaffold(
      title: 'Чэлленж',
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('123'),
            Container(
              height: 1000.0,
              width: 200.0,
              color: Colors.red,
            ),
            Text('123'),
          ],
        ),
      ),
    );
  }
}
