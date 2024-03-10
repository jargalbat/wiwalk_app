import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/data/models/c_response.dart';

class ChallengeDetailResponse extends CResponse {
  Challenge? challenge;
  List<ChallengeDay>? challengeDays;

  ChallengeDetailResponse({this.challenge, this.challengeDays});

  ChallengeDetailResponse.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    challenge = json['Challenge'] != null
        ? Challenge.fromJson(json['Challenge'])
        : null;
    if (json['Txns'] != null) {
      challengeDays = <ChallengeDay>[];
      json['Txns'].forEach((v) {
        challengeDays!.add(ChallengeDay.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    if (challenge != null) {
      data['Challenge'] = challenge!.toJson();
    }
    if (challengeDays != null) {
      data['Txns'] = challengeDays!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Challenge {
  Null? data;
  String? challengeId;
  String? chName;
  String? chType;
  String? beginDate;
  String? endDate;
  int? isPublic;
  String? dayType;
  String? measureType;
  double? measureValue;
  String? createUserId;
  String? createDate;
  String? participantCount;
  String? challengeCode;
  String? status;
  int? isMain;
  int? promocount;
  double? promoBalance;
  String? picture;
  String? challDesc;
  String? remainDateStr;

  Challenge(
      {this.data,
      this.challengeId,
      this.chName,
      this.chType,
      this.beginDate,
      this.endDate,
      this.isPublic,
      this.dayType,
      this.measureType,
      this.measureValue,
      this.createUserId,
      this.createDate,
      this.participantCount,
      this.challengeCode,
      this.status,
      this.isMain,
      this.promocount,
      this.promoBalance,
      this.picture,
      this.challDesc,
      this.remainDateStr});

  Challenge.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    challengeId = json['ChallengeId'];
    chName = json['ChName'];
    chType = json['ChType'];
    beginDate = json['BeginDate'];
    endDate = json['EndDate'];
    isPublic = json['IsPublic'];
    dayType = json['DayType'];
    measureType = json['MeasureType'];
    measureValue = Func.toDouble(json['MeasureValue']);
    createUserId = json['CreateUserId'];
    createDate = json['CreateDate'];
    participantCount = json['ParticipantCount'];
    challengeCode = json['ChallengeCode'];
    status = json['Status'];
    isMain = json['IsMain'];
    promocount = json['Promocount'];
    promoBalance = Func.toDouble(json['PromoBalance']);
    picture = json['Picture'];
    challDesc = json['ChallDesc'];
    remainDateStr = json['RemainDateStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['ChallengeId'] = challengeId;
    data['ChName'] = chName;
    data['ChType'] = chType;
    data['BeginDate'] = beginDate;
    data['EndDate'] = endDate;
    data['IsPublic'] = isPublic;
    data['DayType'] = dayType;
    data['MeasureType'] = measureType;
    data['MeasureValue'] = measureValue;
    data['CreateUserId'] = createUserId;
    data['CreateDate'] = createDate;
    data['ParticipantCount'] = participantCount;
    data['ChallengeCode'] = challengeCode;
    data['Status'] = status;
    data['IsMain'] = isMain;
    data['Promocount'] = promocount;
    data['PromoBalance'] = promoBalance;
    data['Picture'] = picture;
    data['ChallDesc'] = challDesc;
    data['RemainDateStr'] = remainDateStr;
    return data;
  }
}

class ChallengeDay {
  Null? data;
  String? challengeId;
  String? userId;
  String? challDate;
  int? measureLong;
  String? status;
  String? createDate;
  int? stepCount;
  int? promoDone;
  int? promoCount;
  Null? challDayId;
  Null? stepDetailId;
  double? walkDistance;
  String? challDateStr;
  double? stepPercent;
  double? promoPercent;
  double? dayPercent;
  String? weekDay;

  ChallengeDay(
      {this.data,
      this.challengeId,
      this.userId,
      this.challDate,
      this.measureLong,
      this.status,
      this.createDate,
      this.stepCount,
      this.promoDone,
      this.promoCount,
      this.challDayId,
      this.stepDetailId,
      this.walkDistance,
      this.challDateStr,
      this.stepPercent,
      this.promoPercent,
      this.dayPercent,
      this.weekDay});

  ChallengeDay.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    challengeId = json['ChallengeId'];
    userId = json['UserId'];
    challDate = json['ChallDate'];
    measureLong = json['MeasureLong'];
    status = json['Status'];
    createDate = json['CreateDate'];
    stepCount = json['StepCount'];
    promoDone = json['PromoDone'];
    promoCount = json['PromoCount'];
    challDayId = json['ChallDayId'];
    stepDetailId = json['StepDetailId'];
    walkDistance = Func.toDouble(json['WalkDistance']);
    challDateStr = json['ChallDateStr'];
    stepPercent = Func.toDouble(json['StepPercent']);
    promoPercent = Func.toDouble(json['PromoPercent']);
    dayPercent = Func.toDouble(json['DayPercent']);
    weekDay = json['WeekDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['ChallengeId'] = challengeId;
    data['UserId'] = userId;
    data['ChallDate'] = challDate;
    data['MeasureLong'] = measureLong;
    data['Status'] = status;
    data['CreateDate'] = createDate;
    data['StepCount'] = stepCount;
    data['PromoDone'] = promoDone;
    data['PromoCount'] = promoCount;
    data['ChallDayId'] = challDayId;
    data['StepDetailId'] = stepDetailId;
    data['WalkDistance'] = walkDistance;
    data['ChallDateStr'] = challDateStr;
    data['StepPercent'] = stepPercent;
    data['PromoPercent'] = promoPercent;
    data['DayPercent'] = dayPercent;
    data['WeekDay'] = weekDay;
    return data;
  }
}

class Flags {
  String? name;
  String? value;

  Flags({this.name, this.value});

  Flags.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Value'] = value;
    return data;
  }
}
