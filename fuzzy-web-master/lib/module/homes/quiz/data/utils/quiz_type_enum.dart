class ConvertQuizTypeEnum {
  static QuizTypeEnum? convert(String? type) {
    switch (type) {
      case 'pre-quiz':
        return QuizTypeEnum.preQuiz;
      case 'post-quiz':
        return QuizTypeEnum.postQuiz;
      case 'daily-quiz':
        return QuizTypeEnum.dailyQuiz;
      case 'practice-quiz':
        return QuizTypeEnum.practiceQuiz;
      default:
        return null;
    }
  }

  static String? reverse(QuizTypeEnum? type) {
    switch (type) {
      case QuizTypeEnum.preQuiz:
        return 'pre-quiz';
      case QuizTypeEnum.postQuiz:
        return 'post-quiz';
      case QuizTypeEnum.dailyQuiz:
        return 'daily-quiz';
      case QuizTypeEnum.practiceQuiz:
        return 'practice-quiz';
      case null:
      default:
        return null;
    }
  }
}

enum QuizTypeEnum { preQuiz, postQuiz, dailyQuiz, practiceQuiz }
