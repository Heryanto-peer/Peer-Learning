import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/common/widget/snackbar/app_snackbar.dart';
import 'package:fuzzy_web_admin/core/style/app_colors.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/data/model/group_model.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/data/model/kelas_model.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/data/network/kelas_network.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddSiswa extends StatefulWidget {
  final KelasModel classActive;
  final List<GroupModel> groupList;
  final ValueChanged<bool> onAddNewGroup;
  const AddSiswa({super.key, required this.classActive, required this.groupList, required this.onAddNewGroup});

  @override
  State<AddSiswa> createState() => _AddSiswaState();
}

class _AddSiswaState extends State<AddSiswa> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nisController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  TextEditingController classController = TextEditingController();
  Uint8List? imageBytes;
  GroupModel? selectedGroup;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Add Siswa',
        style: AppTextStyle.s24w800(),
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nisController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'NIS',
            ),
          ),
          const Gap(10),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
          ),
          const Gap(10),
          TextField(
            controller: passController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          const Gap(10),
          TextField(
            controller: classController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Class',
            ),
            readOnly: true,
          ),
          const Gap(10),
          Text('Groups', style: AppTextStyle.s18w400()),
          const Gap(5),
          SizedBox(
            height: 50,
            width: Get.width * 0.5,
            child: ListView.builder(
              itemCount: widget.groupList.length + 1,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      setState(() {
                        selectedGroup = widget.groupList[index];
                      });
                    },
                    child: index == widget.groupList.length
                        ? InkWell(
                            onTap: () {
                              eventAddNewGroup();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.green.success,
                              ),
                              child: Text('+ Group Baru', style: AppTextStyle.s18w400(color: AppColors.white.text)),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedGroup?.groupId == widget.groupList[index].groupId ? AppColors.grey.primary.withOpacity(0.6) : AppColors.blue.primary,
                            ),
                            child: Text(widget.groupList[index].groupName ?? '', style: AppTextStyle.s18w400(color: AppColors.white.text)),
                          ));
              },
            ),
          ),
          const Gap(10),
          Text(
            'Photo Profile',
            style: AppTextStyle.s18w400(),
            textAlign: TextAlign.justify,
          ),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: InkWell(
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
              child: imageBytes == null
                  ? DottedBorder(
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
            if (nameController.text.isEmpty || nisController.text.isEmpty) {
              return;
            } else {
              Get.back(result: {
                'nis': int.tryParse(nisController.text),
                'fullname': nameController.text,
                'password': passController.text,
                'group_id': selectedGroup?.groupId,
                'class_id': widget.classActive.classId,
                'image_profile': imageBytes,
              });
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
    groupController.dispose();
    classController.dispose();
    super.dispose();
  }

  eventAddNewGroup() async {
    try {
      final groupController = TextEditingController();
      final groupName = await Get.dialog(
        AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nama Group', style: AppTextStyle.s18w400()),
              const Gap(10),
              TextField(
                controller: groupController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Group',
                ),
              ),
              const Gap(10),
              SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(result: groupController.text);
                  },
                  child: const Text('Add Group'),
                ),
              ),
            ],
          ),
        ),
      );

      final res = await KelasNetwork().addNewGroup([
        {'class_id': widget.classActive.classId, 'group_name': groupName}
      ]);
      Get.back();
      if (res.status == 200) {
        AppSnackbar.succes(title: 'Add Group', succes: 'Group berhasil ditambahkan silahkan refresh halaman');
        widget.onAddNewGroup(true);
      } else {
        AppSnackbar.error(title: 'Add Group', error: 'Group gagal ditambahkan');
      }
    } on Exception catch (_) {
      AppSnackbar.error(title: 'Add Group', error: 'Group gagal ditambahkan');
    }
  }

  @override
  void initState() {
    classController.text = widget.classActive.className ?? '';

    super.initState();
  }

  Future<XFile?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.gallery);
  }
}
