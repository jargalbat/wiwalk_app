import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wiwalk_app/core/router/route_names.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/data/models/challenge/challenges_response.dart';
import 'package:wiwalk_app/modules/challenge/challenge_helper.dart';
import 'package:wiwalk_app/widgets/c_toast.dart';
import 'package:wiwalk_app/widgets/cards/stroke_card.dart';

class ChallengeItemWidget extends StatelessWidget {
  const ChallengeItemWidget({
    super.key,
    required this.challengeItem,
    this.margin,
  });

  final ChallengeItem challengeItem;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return StrokeCard(
      onTap: () {
        if (challengeItem.challengeId == null) {
          showToast('Challenge id not found.');
          return;
        }

        context.goNamed(
          RouteNames.challengeDetail,
          pathParameters: {'id': challengeItem.challengeId ?? ''},
        );
      },
      margin: margin,
      child: Container(
        padding: const EdgeInsets.all(CSize.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Func.isNotEmpty(challengeItem.picture))
              Image.network(
                challengeItem.picture ?? '',
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Text('asdf'); //'Couldn't load image'
                },
              ),

            _status(),
            Text(challengeItem.chName ?? ''),
            Text(challengeItem.isPublic == 1 ? 'Бүх хэрэглэгчид' : 'Хаалттай'),
            Text(ChallengeHelper.getChallengeTypeName(challengeItem.chType) ??
                ''),

            /// Үлдсэн хугацаа
            if (Func.isNotEmpty(challengeItem.remainDateStr))
              Text(challengeItem.remainDateStr ?? ''),

            if (Func.toDouble(challengeItem.promoBalance) > 0)
              Text('${Func.toAmount(challengeItem.promoBalance)}₮'),
          ],
        ),
      ),
    );
  }

  Widget _status() {
    String? text;

    if (challengeItem.isMain == 1) {
      text = 'Өнөөдрийн';
    } else {
      text = ChallengeHelper.getChallengeStatusName(challengeItem.status);
    }

    return Text(text ?? '');
  }
}
