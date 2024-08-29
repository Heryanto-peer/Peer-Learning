import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';
import 'package:fuzzy_web_admin/module/homes/materi/data/network/materi_network.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AddMateri extends StatefulWidget {
  final String subjectID;
  const AddMateri({super.key, required this.subjectID});

  @override
  State<AddMateri> createState() => _AddMateriState();
}

class _AddMateriState extends State<AddMateri> {
  TextEditingController nameController = TextEditingController();
  PlatformFile? pickedFile;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Add materi',
        style: AppTextStyle.s24w800(),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: Get.width * 0.4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    pickedFile == null ? 'No File Selected' : pickedFile!.name,
                    style: AppTextStyle.s18w400(),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Gap(10),
                Flexible(child: ElevatedButton(onPressed: () => loading == false ? pickFile() : null, child: loading == false ? const Text('Choose File') : const CircularProgressIndicator())),
              ],
            ),
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
            if (pickedFile == null || nameController.text.isEmpty) {
              return;
            }
            final network = MateriNetwork();
            final materi = dio.MultipartFile.fromBytes(pickedFile!.bytes!, filename: pickedFile!.name);

            try {
              final res = await network.addMateri(data: {
                'subject_id': widget.subjectID,
                'materi_name': nameController.text,
                'subject_materi': materi,
              });

              if (res.status == 200) {
                Get.back(result: true);
              }
            } on Exception catch (e) {
              debugPrint(e.toString());
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  pickFile() async {
    setState(() {
      loading = true;
    });
    final FilePickerResult? res = await FilePicker.platform.pickFiles(allowCompression: true, type: FileType.custom, allowedExtensions: ['pdf']);
    if (res != null) {
      if (res.files.isNotEmpty) {
        setState(() {
          pickedFile = res.files.first;
          nameController.text = pickedFile!.name.split('.').first;
          loading = false;
        });
        return;
      }
    }

    setState(() {
      loading = false;
    });
  }
}
