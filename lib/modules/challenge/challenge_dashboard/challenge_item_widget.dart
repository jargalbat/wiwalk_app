import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/router/route_names.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/data/models/challenge/challenges_response.dart';
import 'package:wiwalk_app/modules/challenge/challenge_helper.dart';
import 'package:wiwalk_app/widgets/c_image.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(CSize.spacing16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Image
                CImage(
                  imageUrl: challengeItem.picture,
                  height: 84.0,
                  width: 84.0,
                ),

                const SizedBox(width: CSize.spacing16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Status
                    _status(context),

                    const SizedBox(height: 10.0),

                    /// Name
                    Text(
                      challengeItem.chName ?? '',
                      style: context.textStyles.heading16?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10.0),

                    /// Name
                    Text(
                      challengeItem.isPublic == 1
                          ? 'Бүх хэрэглэгчид'
                          : 'Хаалттай',
                      style: context.textStyles.body14?.copyWith(
                        color: context.colors.text3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: context.theme.dividerColor),
          Row(
            children: [
              Text(ChallengeHelper.getChallengeTypeName(challengeItem.chType) ??
                  ''),

              /// Үлдсэн хугацаа
              if (Func.isNotEmpty(challengeItem.remainDateStr))
                Text(challengeItem.remainDateStr ?? ''),

              if (Func.toDouble(challengeItem.promoBalance) > 0)
                Text('${Func.toAmount(challengeItem.promoBalance)}₮'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _status(BuildContext context) {
    String? text;
    Color? textColor;
    Color? gradientColor1;
    Color? gradientColor2;

    if (challengeItem.isMain == 1) {
      text = 'Өнөөдрийн';
      gradientColor1 = context.theme.primaryColor;
      gradientColor2 = context.theme.primaryColor;
    } else {
      text = ChallengeHelper.getChallengeStatusName(challengeItem.status);

      switch (challengeItem.status) {
        case 'Started':
          textColor = const Color(0xFF2A830B);
          gradientColor1 = const Color(0xFF45CD15).withOpacity(0.2);
          gradientColor2 = const Color(0xFF45CD15).withOpacity(0.3);
        case 'New':
          textColor = const Color(0xFFD88100);
          gradientColor1 = const Color(0xFFFF9800);
          gradientColor2 = const Color(0xFFFF9800).withOpacity(0.4);
        // case 'Completed':
        // default:
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            gradientColor1 ?? context.theme.primaryColor,
            gradientColor2 ?? context.theme.primaryColor,
          ],
        ),
      ),
      child: Text(
        text,
        style: context.textStyles.body12?.copyWith(
          color: textColor ?? context.colors.textWhite,
        ),
      ),
    );
  }
}
