import 'dart:io';

import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/widgets/custom_textfeild.dart';
import 'package:seller_app/widgets/loading_indicator.dart';
import 'package:seller_app/widgets/text_stryle.dart';

import '../../controller/profile_controller.dart';

class EditingScreen extends StatefulWidget {
  final String? username;
  const EditingScreen({super.key, this.username});

  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  var controller = Get.find<ProfileController>();
  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: editProfile, size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator()
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      if (controller.profileImgPath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink =
                            controller.snapshot['imgUrl'];
                      }
                      if (controller.snapshot['password'] ==
                          controller.oldpassController.text) {
                        await controller.changeAuthPassword(
                            email: controller.snapshot['email'],
                            password: controller.oldpassController.text,
                            newPassword: controller.nameController.text);
                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController,
                            password: controller.newpassController.text);
                        VxToast.show(context, msg: "Updated");
                      } else if (controller
                              .oldpassController.text.isEmptyOrNull &&
                          controller.newpassController.text.isEmptyOrNull) {
                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController,
                            password: controller.snapshot['password']);
                      } else {
                        VxToast.show(context, msg: "some error occur");
                        controller.isLoading(false);
                      }
                    },
                    child: normaltext(text: save, color: fontGrey))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              controller.snapshot['imageUrl'] == ''
                  ? Image.network(
                      controller.snapshot['imageUrl'],
                      width: 100,
                      fit: BoxFit.fill,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : Image.file(
                      File(controller.profileImgPath.value),
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: white),
                  onPressed: () {
                    controller.changeImage(context);
                  },
                  child: normaltext(text: changeImage, color: fontGrey)),
              10.heightBox,
              const Divider(color: white),
              customTextField(
                  label: name,
                  hint: "Baaba Devs",
                  controller: controller.nameController),
              10.heightBox,
              Align(child: boldText(text: "Change your password")),
              10.heightBox,
              customTextField(
                  label: password,
                  hint: passwordHint,
                  controller: controller.newpassController),
              10.heightBox,
              customTextField(
                  label: confirm,
                  hint: password,
                  controller: controller.oldpassController),
            ],
          ),
        ),
      ),
    );
  }
}
