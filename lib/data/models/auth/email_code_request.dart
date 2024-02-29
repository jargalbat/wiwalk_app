import 'package:wiwalk_app/data/models/c_request.dart';

class EmailCodeRequest extends CRequest {
  String? userId;
  String? email;

  EmailCodeRequest({this.userId, this.email});

  EmailCodeRequest.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    userId = json['UserId'];
    email = json['Email'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    data['UserId'] = userId;
    data['Email'] = email;
    return data;
  }
}
