import 'package:wiwalk_app/data/models/c_response.dart';

class SignUpResponse extends CResponse {
  String? token;

  SignUpResponse({this.token});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    token = json['Token'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    data['Token'] = token;
    return data;
  }
}
