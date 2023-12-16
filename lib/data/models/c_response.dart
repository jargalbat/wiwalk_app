import 'package:wiwalk_app/data/api/api_helper.dart';

class CResponse {
  String? responseDate;
  int? retType;
  String? retDesc;

  CResponse({
    this.responseDate,
    this.retType,
    this.retDesc,
  });

  CResponse.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  void fromJson(Map<String, dynamic> json) {
    responseDate = json['ResponseDate'];
    retType = json['RetType'];
    retDesc = json['RetDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseDate'] = responseDate;
    data['RetType'] = retType;
    data['RetDesc'] = retDesc;
    return data;
  }

  @override
  String toString() {
    return '{ '
        'ResponseDate: $responseDate, RetType: $retType, RetDesc: $retDesc }';
  }
}
