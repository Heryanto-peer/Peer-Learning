import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';
import 'package:get/get.dart';

class AddKelas extends StatefulWidget {
  const AddKelas({
    super.key,
  });

  @override
  State<AddKelas> createState() => _AddKelasState();
}

class _AddKelasState extends State<AddKelas> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Tambah Kelas Baru',
        style: AppTextStyle.s24w800(),
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nama Kelas',
            ),
          ),
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
            if (nameController.text.isEmpty) {
              return;
            } else {
              Get.back(result: {
                'class_name': nameController.text,
              });
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

}
