import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AddMapel extends StatefulWidget {
  const AddMapel({
    super.key,
  });

  @override
  State<AddMapel> createState() => _AddSiswaState();
}

class _AddSiswaState extends State<AddMapel> {
  TextEditingController materi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Tambah Materi Pelajaran Baru',
        style: AppTextStyle.s24w800(),
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: materi,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nama Mapel',
            ),
          ),
          const Gap(10),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (materi.text.isEmpty) {
              return;
            } else {
              Get.back(result: {'subject_name': materi.text, 'subject_level': 1, 'nip': 2311099});
            }
          },
          child: const Text('Tambah'),
        ),
      ],
    );
  }
}
