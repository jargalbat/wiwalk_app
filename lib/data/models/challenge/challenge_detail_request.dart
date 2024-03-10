import 'package:wiwalk_app/data/models/c_request.dart';

class ChallengeDetailRequest extends CRequest {
  String? challengeId;
  String? repDate;

  ChallengeDetailRequest({this.challengeId, this.repDate});

  ChallengeDetailRequest.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    challengeId = json['ChallengeId'];
    repDate = json['RepDate'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    data['ChallengeId'] = challengeId;
    data['RepDate'] = repDate;
    return data;
  }
}
