import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';
import 'package:fuzzy_web_admin/module/homes/quiz/data/model/quiz_model.dart';
import 'package:fuzzy_web_admin/module/homes/quiz/data/network/quiz_network.dart';
import 'package:fuzzy_web_admin/module/homes/quiz/data/utils/quiz_type_enum.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class UpdateQuestion extends StatefulWidget {
  final QuizModel quiz;
  const UpdateQuestion({super.key, required this.quiz});

  @override
  State<UpdateQuestion> createState() => _UpdateQuestionState();
}

class _UpdateQuestionState extends State<UpdateQuestion> {
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  TextEditingController opt1Controller = TextEditingController();
  TextEditingController opt2Controller = TextEditingController();
  TextEditingController opt3Controller = TextEditingController();
  TextEditingController opt4Controller = TextEditingController();
  int point = 0;
  QuizTypeEnum type = QuizTypeEnum.preQuiz;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Update Quiz',
        style: AppTextStyle.s24w800(),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: Get.width * 0.4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: questionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Question',
              ),
            ),
            const Gap(10),
            TextField(
              controller: answerController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Answer',
              ),
            ),
            const Gap(10),
            TextField(
              controller: opt1Controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Option 1',
              ),
            ),
            const Gap(10),
            TextField(
              controller: opt2Controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Option 2',
              ),
            ),
            const Gap(10),
            TextField(
              controller: opt3Controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Option 3',
              ),
            ),
            const Gap(10),
            TextField(
              controller: opt4Controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Option 4',
              ),
            ),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Point: $point',
                    style: AppTextStyle.s18w400(),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Gap(10),
                IconButton(
                  onPressed: () {
                    setState(() {
                      point = point + 1;
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (point > 0) {
                        point = point - 1;
                      }
                    });
                  },
                  icon: const Icon(Icons.remove),
                ),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Type: ${type.name}',
                    style: AppTextStyle.s18w400(),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Gap(10),
                IconButton(
                  onPressed: () {
                    setState(() {
                      type = type == QuizTypeEnum.dailyQuiz
                          ? QuizTypeEnum.preQuiz
                          : QuizTypeEnum.preQuiz == type
                              ? QuizTypeEnum.postQuiz
                              : QuizTypeEnum.dailyQuiz;
                    });
                  },
                  icon: const Icon(Icons.sync),
                ),
              ],
            ),
            const Gap(10),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final network = QuizNetwork();
            final Map<String, dynamic> data = {
              'question_id': widget.quiz.questionId,
              'question': questionController.text,
              'answer': answerController.text,
              'option1': opt1Controller.text,
              'option2': opt2Controller.text,
              'option3': opt3Controller.text,
              'option4': opt4Controller.text,
              'poin': point,
              'type': ConvertQuizTypeEnum.reverse(type),
            };

            final res = await network.updateQuiz(data: data);
            if (res.data != null) {
              Get.back(result: true);
            }
          },
          child: const Text('Update'),
        ),
      ],
    );
  }

  @override
  void initState() {
    questionController.text = widget.quiz.question ?? '';
    answerController.text = widget.quiz.answer ?? '';
    opt1Controller.text = widget.quiz.option1 ?? '';
    opt2Controller.text = widget.quiz.option2 ?? '';
    opt3Controller.text = widget.quiz.option3 ?? '';
    opt4Controller.text = widget.quiz.option4 ?? '';
    point = widget.quiz.poin ?? 0;
    type = ConvertQuizTypeEnum.convert(widget.quiz.type) ?? QuizTypeEnum.dailyQuiz;

    super.initState();
  }
}
