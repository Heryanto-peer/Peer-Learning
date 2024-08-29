import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/core/style/app_colors.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/data/model/group_model.dart';
import 'package:fuzzy_web_admin/module/homes/siswa/data/model/siswa_model.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditSiswa extends StatefulWidget {
  final SiswaModel siswa;
  const EditSiswa({super.key, required this.siswa});

  @override
  State<EditSiswa> createState() => _EditSiswaState();
}

class _EditSiswaState extends State<EditSiswa> {
  late SiswaModel siswa;
  TextEditingController nisController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController poinController = TextEditingController();
  TextEditingController passController = TextEditingController(text: 'password');
  Uint8List? imageBytes;
  GroupModel? selectedGroup;
  bool changePassword = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Edit Siswa',
        style: AppTextStyle.s24w800(),
        textAlign: TextAlign.center,
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(minWidth: Get.width * 0.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nisController,
              enabled: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'NIS',
              ),
            ),
            const Gap(10),
            TextField(
              controller: passController,
              obscureText: !changePassword,
              obscuringCharacter: '#',
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  suffix: InkWell(
                    onTap: () {
                      setState(() {
                        changePassword = !changePassword;
                        if (!changePassword) {
                          passController.text = 'password';
                        }
                      });
                    },
                    child: Text(
                      'Ganti',
                      style: TextStyle(color: AppColors.blue.primary),
                    ),
                  )),
            ),
            const Gap(10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nama Lengkap',
              ),
            ),
            const Gap(10),
            TextField(
              controller: poinController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Poin',
              ),
            ),
            const Gap(10),
            Text(
              'Photo profile',
              style: AppTextStyle.s18w400(),
              textAlign: TextAlign.justify,
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: siswa.imageProfile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox(
                        height: 258,
                        width: Get.width * 0.5,
                        child: Image.network(
                          siswa.imageProfile!,
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ),
                      ),
                    )
                  : imageBytes == null
                      ? InkWell(
                          onTap: () async {
                            final res = await pickImageFromGallery();
                            if (res != null) {
                              res.openRead().listen((value) {
                                setState(() {
                                  imageBytes = value;
                                });
                              });
                            }
                          },
                          child: DottedBorder(
                            color: AppColors.blue.primary,
                            radius: const Radius.circular(10),
                            strokeWidth: 0.8,
                            borderType: BorderType.RRect,
                            dashPattern: const [6, 6],
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 28.0),
                                child: Icon(
                                  Icons.person_rounded,
                                  color: AppColors.blue.primary,
                                  size: 58,
                                ),
                              ),
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: SizedBox(
                            height: 258,
                            width: Get.width * 0.5,
                            child: Image.memory(
                              imageBytes!,
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
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
          onPressed: () {
            if (nameController.text.isEmpty || nisController.text.isEmpty) {
              return;
            } else {
              final data = {
                'nis': int.tryParse(nisController.text),
                'fullname': nameController.text,
                'password': changePassword ? passController.text : '',
                'poin': poinController.text,
                'image_profile': imageBytes
              };

              Get.back(result: data);
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
    nisController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    siswa = widget.siswa;
    nisController.text = '${siswa.nis ?? ''}';
    nameController.text = siswa.fullname ?? '';
    super.initState();
  }

  Future<XFile?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.gallery);
  }
}
