import 'package:wiwalk_app/data/api/api_helper.dart';

class CRequest {
  CRequest();

  final aPIUser = ApiHelper.clientId;
  final aPIKey = ApiHelper.clientSecret;
  int? pId;
  int? pSize;
  String? secretKey;
  String? lang;

  void fromJson(Map<String, dynamic> json) {
    // aPIUser = json['APIUser'];
    // aPIKey = json['APIKey'];`
    // pId = json['pId'];
    // pSize = json['pSize'];
    // secretKey = json['SecretKey'];
    // lang = json['Lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['APIUser'] = aPIUser;
    data['APIKey'] = aPIKey;
    data['pId'] = pId;
    data['pSize'] = pSize;
    data['SecretKey'] = secretKey;
    data['Lang'] = lang;

    return data;
  }
}
