class GroupChallenge {
  String? id;
  int? progress;
  List<ChallengeOld>? challenges;

  GroupChallenge({this.id, this.progress, this.challenges});

  GroupChallenge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    progress = json['progress'];
    if (json['challenges'] != null) {
      challenges = <ChallengeOld>[];
      json['challenges'].forEach((v) {
        challenges!.add(ChallengeOld.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['progress'] = progress;
    if (challenges != null) {
      data['challenges'] = challenges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChallengeOld {
  String? id;
  String? title;
  String? type;
  String? unit;
  double? progress;
  int? target;
  List<Promotion>? promotions;

  ChallengeOld(
      {this.id,
      this.title,
      this.type,
      this.unit,
      this.progress,
      this.target,
      this.promotions});

  ChallengeOld.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    unit = json['unit'];
    progress = json['progress'];
    target = json['target'];
    if (json['promotions'] != null) {
      promotions = <Promotion>[];
      json['promotions'].forEach((v) {
        promotions!.add(Promotion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['unit'] = unit;
    data['progress'] = progress;
    data['target'] = target;
    if (promotions != null) {
      data['promotions'] = promotions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Promotion {
  String? id;
  String? type;
  String? title;
  String? description;
  String? url;

  Promotion({this.id, this.type, this.title, this.description, this.url});

  Promotion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    return data;
  }
}
