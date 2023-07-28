import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/controller/auth_controller.dart';
import 'package:seller_app/controller/profile_controller.dart';
import 'package:seller_app/services/store_services.dart';
import 'package:seller_app/views/auth_screen/login_screen.dart';
import 'package:seller_app/views/settings/edit_screen.dart';
import 'package:seller_app/views/shoping/shoping_screen.dart';
import 'package:seller_app/widgets/loading_indicator.dart';
import 'package:seller_app/widgets/text_stryle.dart';

import '../messages/messages_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: settings, size: 16.0),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => EditingScreen(
                      username: controller.snapshot['vendor_name'],
                    ));
              },
              icon: const Icon(Icons.edit)),
          TextButton(
              onPressed: () async {
                Get.find<AuthController>().signoutMethod(context);
                Get.offAll(() => const LoginScreen());
              },
              child: normaltext(text: logout))
        ],
      ),
      body: FutureBuilder(
          future: StoreServices.getProfile(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              controller.snapshot = snapshot.data!.docs[0];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                        leading: controller.snapshot['imageUrl'] == ''
                            ? Image.asset(imgproduct,
                                    width: 100, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make()
                            : Image.network(
                                controller.snapshot['imageUrl'],
                                width: 100,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make(),
                        title: boldText(
                            text: "${controller.snapshot['vendor_name']}"),
                        subtitle: normaltext(
                            text: "${controller.snapshot['email']}")),
                    Divider(),
                    10.heightBox,
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: List.generate(
                            profileButtonIcons.length,
                            (index) => ListTile(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        {
                                          Get.to(() => ShoppingSetting());
                                          break;
                                        }
                                      case 1:
                                        {
                                          Get.to(() => MessageScreen());
                                          break;
                                        }
                                    }
                                  },
                                  leading: Icon(
                                    profileButtonIcons[index],
                                    color: white,
                                  ),
                                  title: normaltext(
                                      text: profileButtonsTitle[index]),
                                )),
                      ),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
