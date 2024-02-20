import 'package:wiwalk_app/data/models/c_request.dart';

class PhoneCodeRequest extends CRequest {
  String? userId;
  String? phone;

  PhoneCodeRequest({this.userId, this.phone});

  PhoneCodeRequest.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    userId = json['UserId'];
    phone = json['Phone'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    data['UserId'] = userId;
    data['Phone'] = phone;
    return data;
  }
}
