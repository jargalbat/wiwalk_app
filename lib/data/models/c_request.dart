import 'package:wiwalk_app/data/api/api_helper.dart';

class CRequest {
  CRequest();

  String aPIUser = ApiHelper.clientId;
  String aPIKey = ApiHelper.clientSecret;

  // BaseRequest.fromJson(Map<String, dynamic> json) {
    // aPIUser = json['APIUser'];
    // aPIKey = json['APIKey'];
  // }

  // BaseRequest.fromJson(Map<String, dynamic> json) {
  //   fromJson(json);
  // }

  void fromJson(Map<String, dynamic> json) {
    // message = json['message'];
    // data = json['data'];
    // subscribeLink = json['subscribe_link'];
    // links = json["links"] == null ? null : Links.fromJson(json["links"]);
    // meta = json["meta"] == null ? null : Meta.fromJson(json["meta"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['APIUser'] = aPIUser;
    data['APIKey'] = aPIKey;
    return data;
  }
}
