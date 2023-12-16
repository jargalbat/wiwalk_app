import 'package:wiwalk_app/data/models/c_response.dart';

class LoginResponse extends CResponse {
  String? token;
  String? phone;
  String? email;
  String? firstName;
  String? lastName;
  String? userStatus;
  String? confirmEmail;
  String? confirmPhone;

  LoginResponse({
    this.token,
    this.phone,
    this.email,
    this.firstName,
    this.lastName,
    this.userStatus,
    this.confirmEmail,
    this.confirmPhone,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    token = json['Token'];
    phone = json['Phone'];
    email = json['Email'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    userStatus = json['UserStatus'];
    confirmEmail = json['ConfirmEmail'];
    confirmPhone = json['ConfirmPhone'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    data['Token'] = token;
    data['Phone'] = phone;
    data['Email'] = email;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['UserStatus'] = userStatus;
    data['ConfirmEmail'] = confirmEmail;
    data['ConfirmPhone'] = confirmPhone;
    return data;
  }
}
