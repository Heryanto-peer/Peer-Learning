import 'package:fuzzy_mobile_user/module/quiz/challenge_quiz/data/utils/quiz_type_enum.dart';

class ConvertPoinType {
  static String convertPoinType(PoinTypeEnum? poinTypeEnum) {
    if (poinTypeEnum == null) return '';

    if (poinTypeEnum == PoinTypeEnum.prePoin) {
      return 'pre-poin';
    } else if (poinTypeEnum == PoinTypeEnum.postPoin) {
      return 'post-poin';
    } else if (poinTypeEnum == PoinTypeEnum.dailyPoin) {
      return 'daily-poin';
    } else {
      return 'fuzzy-poin';
    }
  }

  static PoinTypeEnum convertPoinTypeEnum(String poinType) {
    if (poinType == 'pre-poin') {
      return PoinTypeEnum.prePoin;
    } else if (poinType == 'post-poin') {
      return PoinTypeEnum.postPoin;
    } else if (poinType == 'daily-poin') {
      return PoinTypeEnum.dailyPoin;
    } else {
      return PoinTypeEnum.fuzzyPoin;
    }
  }

  static String convertQuizForDB(PoinTypeEnum? poinTypeEnum) {
    if (poinTypeEnum == null) return '';
    if (poinTypeEnum == PoinTypeEnum.prePoin) {
      return 'pre-poin';
    } else if (poinTypeEnum == PoinTypeEnum.postPoin) {
      return 'post-poin';
    } else if (poinTypeEnum == PoinTypeEnum.dailyPoin) {
      return 'daily-poin';
    } else {
      return 'fuzzy-poin';
    }
  }

  static String convertQuizTypeToPoinType(QuizTypeEnum quizType) {
    if (quizType == QuizTypeEnum.preQuiz) {
      return 'pre-poin';
    } else if (quizType == QuizTypeEnum.postQuiz) {
      return 'post-poin';
    } else {
      return 'daily-poin';
    }
  }
}

enum PoinTypeEnum { prePoin, postPoin, dailyPoin, fuzzyPoin }
