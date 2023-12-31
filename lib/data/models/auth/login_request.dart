import 'package:wiwalk_app/data/models/c_request.dart';

class LoginRequest extends CRequest {
  String? userName;
  String? passCode;

  LoginRequest({this.userName, this.passCode});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    userName = json['UserName'];
    passCode = json['PassCode'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    data['UserName'] = userName;
    data['PassCode'] = passCode;
    return data;
  }
}
