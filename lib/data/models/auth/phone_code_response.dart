import 'package:wiwalk_app/data/models/c_response.dart';

class PhoneCodeResponse extends CResponse {
  String? code;

  PhoneCodeResponse({this.code});

  PhoneCodeResponse.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    code = json['Code'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    data['Code'] = code;
    return data;
  }
}
