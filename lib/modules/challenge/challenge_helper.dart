class ChallengeHelper {
  static String getChallengeStatusName(String? status) {
    switch (status) {
      case 'Started':
        return 'Эхэлсэн';
      case 'New':
        return 'Шинэ';
      case 'Completed':
        return 'Дууссан';
      default:
        return '';
    }
  }

  static String getChallengeTypeName(String? type) {
    switch (type) {
      case 'Walk':
        return 'Алхалт';
      default:
        return '';
    }
  }

  static String getMeasureTypeName(String? type) {
    switch (type) {
      case 'KMETER':
        return 'км';
      default:
        return '';
    }
  }

  static String getIsPublicName(int? isPublic) {
    if (isPublic == 1) {
      return 'Нээлттэй';
    } else {
      return 'Хаалттай';
    }
  }
}
