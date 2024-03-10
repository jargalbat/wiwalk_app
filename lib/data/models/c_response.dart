import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/data/api/api_helper.dart';

class CResponse {
  String? responseDate;
  int? retType;
  String? retDesc;
  int? pTotal;

  CResponse({
    this.responseDate,
    this.retType,
    this.retDesc,
    this.pTotal,
  });

  CResponse.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  void fromJson(Map<String, dynamic> json) {
    responseDate = json['ResponseDate'];
    retType = json['RetType'];
    retDesc = json['RetDesc'];
    pTotal = json['pTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseDate'] = responseDate;
    data['RetType'] = retType;
    data['RetDesc'] = retDesc;
    data['pTotal'] = pTotal;
    return data;
  }

  @override
  String toString() {
    return '{ '
        'ResponseDate: $responseDate, '
        'RetType: $retType, '
        'RetDesc: $retDesc '
        'pTotal: $pTotal '
        '}';
  }

  static String getMessage(CResponse cRes, String placeHolder) {
    return Func.isNotEmpty(cRes.retDesc) ? cRes.retDesc! : placeHolder;
  }
}
