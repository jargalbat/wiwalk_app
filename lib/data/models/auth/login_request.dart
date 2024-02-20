import 'package:wiwalk_app/data/models/c_request.dart';

class LoginRequest extends CRequest {
  String? userName;
  String? passCode;
  String? deviceId;
  bool? biometricStatus;

  LoginRequest({
    this.userName,
    this.passCode,
    this.deviceId,
    this.biometricStatus,
  });

  LoginRequest.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    userName = json['UserName'];
    passCode = json['PassCode'];
    deviceId = json['DeviceId'];
    biometricStatus = json['BiometricStatus'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    data['APIUser'] = aPIUser;
    data['APIKey'] = aPIKey;
    data['UserName'] = userName;
    data['PassCode'] = passCode;
    data['DeviceId'] = deviceId;
    data['BiometricStatus'] = biometricStatus;
    return data;
  }
}
