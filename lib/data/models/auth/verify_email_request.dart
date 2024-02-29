import 'package:wiwalk_app/data/models/c_request.dart';

class VerifyEmailRequest extends CRequest {
  String? userId;
  String? code;

  VerifyEmailRequest({this.userId, this.code});

  VerifyEmailRequest.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    userId = json['UserId'];
    code = json['Code'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    data['UserId'] = userId;
    data['Code'] = code;
    return data;
  }
}
