import 'package:flutter/foundation.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/data/models/c_response.dart';

class ChallengesResponse extends CResponse {
  List<ChallengeItem>? challenges;
  List<ChallengeFilter>? filters;

  ChallengesResponse({
    this.challenges,
    this.filters,
  });

  ChallengesResponse.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    if (json['challenges'] != null) {
      challenges = <ChallengeItem>[];
      json['challenges'].forEach((v) {
        try {
          challenges!.add(ChallengeItem.fromJson(v));
        } catch (e) {
          if (kDebugMode) print(e);
        }
      });
    }
    if (json['filters'] != null) {
      filters = <ChallengeFilter>[];
      json['filters'].forEach((v) {
        try {
          filters!.add(ChallengeFilter.fromJson(v));
        } catch (e) {
          if (kDebugMode) print(e);
        }
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    if (challenges != null) {
      data['challenges'] = challenges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChallengeItem {
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
  double? promoBalance;
  String? picture;
  String? remainDateStr;

  ChallengeItem({
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
    this.promoBalance,
    this.picture,
    this.remainDateStr,
  });

  ChallengeItem.fromJson(Map<String, dynamic> json) {
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
    promoBalance = Func.toDouble(json['PromoBalance']);
    picture = json['Picture'];
    remainDateStr = json['RemainDateStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['PromoBalance'] = promoBalance;
    data['Picture'] = picture;
    data['RemainDateStr'] = remainDateStr;
    return data;
  }
}

class ChallengeFilter {
  String? name;
  String? value;

  ChallengeFilter({this.name, this.value});

  ChallengeFilter.fromJson(Map<String, dynamic> json) {
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
