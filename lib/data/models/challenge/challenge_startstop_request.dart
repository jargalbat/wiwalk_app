import 'package:wiwalk_app/data/models/c_request.dart';

class ChallengeStartStopRequest extends CRequest {
  String? challengeId;
  int? isStart;

  ChallengeStartStopRequest({this.challengeId, this.isStart});

  ChallengeStartStopRequest.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    challengeId = json['challengeId'];
    isStart = json['IsStart'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    data['challengeId'] = challengeId;
    data['IsStart'] = isStart;
    return data;
  }
}
