class ConvertQuizType {
  static String convertQuizForDB(QuizTypeEnum? quizTypeEnum) {
    if (quizTypeEnum == null) return '';
    if (quizTypeEnum == QuizTypeEnum.dailyQuiZ) {
      return 'daily-quiz';
    } else if (quizTypeEnum == QuizTypeEnum.preQuiz) {
      return 'pre-quiz';
    } else if (quizTypeEnum == QuizTypeEnum.practiceQuiz) {
      return 'practice-quiz';
    } else {
      return 'post-quiz';
    }
  }

  static String convertQuizType(QuizTypeEnum? quizTypeEnum) {
    if (quizTypeEnum == null) return '';
    if (quizTypeEnum == QuizTypeEnum.dailyQuiZ) {
      return 'Daily Quiz';
    } else if (quizTypeEnum == QuizTypeEnum.preQuiz) {
      return 'Pre Quiz';
    } else if (quizTypeEnum == QuizTypeEnum.practiceQuiz) {
      return 'Latihan';
    } else {
      return 'Post Quiz';
    }
  }

  static QuizTypeEnum convertQuizTypeEnum(String quizType) {
    if (quizType == 'daily_quiz') {
      return QuizTypeEnum.dailyQuiZ;
    } else if (quizType == 'pre_quiz') {
      return QuizTypeEnum.preQuiz;
    } else if (quizType == 'practice_quiz') {
      return QuizTypeEnum.practiceQuiz;
    } else {
      return QuizTypeEnum.postQuiz;
    }
  }
}

enum QuizTypeEnum { dailyQuiZ, preQuiz, postQuiz, practiceQuiz }
