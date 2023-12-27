import 'package:wiwalk_app/data/models/c_response.dart';

class SurveyQuestionsResponse extends CResponse {
  List<SurveyQuestion>? surveyQuestions;

  SurveyQuestionsResponse({this.surveyQuestions});

  SurveyQuestionsResponse.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    if (json['surveyQuestions'] != null) {
      surveyQuestions = <SurveyQuestion>[];
      json['surveyQuestions'].forEach((v) {
        surveyQuestions!.add(SurveyQuestion.fromJson(v));
      });
    }
    responseDate = json['ResponseDate'];
    retType = json['RetType'];
    retDesc = json['RetDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(super.toJson());
    if (surveyQuestions != null) {
      data['surveyQuestions'] =
          surveyQuestions!.map((v) => v.toJson()).toList();
    }
    data['ResponseDate'] = responseDate;
    data['RetType'] = retType;
    data['RetDesc'] = retDesc;
    return data;
  }
}

class SurveyQuestion {
  String? questionId;
  String? question;
  List<SurveyAnswer>? surveyAnswers;

  SurveyQuestion({this.questionId, this.question, this.surveyAnswers});

  SurveyQuestion.fromJson(Map<String, dynamic> json) {
    questionId = json['QuestionId'];
    question = json['Question'];
    if (json['surveyAnswers'] != null) {
      surveyAnswers = <SurveyAnswer>[];
      json['surveyAnswers'].forEach((v) {
        surveyAnswers!.add(SurveyAnswer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['QuestionId'] = questionId;
    data['Question'] = question;
    if (surveyAnswers != null) {
      data['surveyAnswers'] = surveyAnswers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SurveyAnswer {
  String? answerId;
  String? answer;

  SurveyAnswer({this.answerId, this.answer});

  SurveyAnswer.fromJson(Map<String, dynamic> json) {
    answerId = json['AnswerId'];
    answer = json['Answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AnswerId'] = answerId;
    data['Answer'] = answer;
    return data;
  }
}
