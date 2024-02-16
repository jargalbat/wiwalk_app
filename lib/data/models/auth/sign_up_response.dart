import 'package:wiwalk_app/data/models/c_response.dart';

class SignUpResponse extends CResponse {
  String? userId;

  SignUpResponse({this.userId});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    userId = json['UserId'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    data['UserId'] = userId;
    return data;
  }
}
