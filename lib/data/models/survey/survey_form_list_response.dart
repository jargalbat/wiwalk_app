import 'package:wiwalk_app/data/models/c_response.dart';

class SurveyFormListResponse extends CResponse {
  List<SurveyFormLists>? surveyFormLists;

  SurveyFormListResponse({this.surveyFormLists});

  SurveyFormListResponse.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    if (json['surveyFormLists'] != null) {
      surveyFormLists = <SurveyFormLists>[];
      json['surveyFormLists'].forEach((v) {
        surveyFormLists!.add(SurveyFormLists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    if (surveyFormLists != null) {
      data['surveyFormLists'] =
          surveyFormLists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SurveyFormLists {
  String? formId;
  String? formName;

  SurveyFormLists({this.formId, this.formName});

  SurveyFormLists.fromJson(Map<String, dynamic> json) {
    formId = json['FormId'];
    formName = json['FormName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FormId'] = formId;
    data['FormName'] = formName;
    return data;
  }
}
