import 'package:wiwalk_app/data/models/c_response.dart';

class EducationsResponse extends CResponse {
  List<Education>? educations;

  EducationsResponse({this.educations});

  EducationsResponse.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    if (json['educationLists'] != null) {
      educations = <Education>[];
      json['educationLists'].forEach((v) {
        educations!.add(Education.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    if (educations != null) {
      data['educationLists'] = educations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Education {
  String? educationId;
  String? education;

  Education({this.educationId, this.education});

  Education.fromJson(Map<String, dynamic> json) {
    educationId = json['EducationId'];
    education = json['Education'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EducationId'] = educationId;
    data['Education'] = education;
    return data;
  }
}
