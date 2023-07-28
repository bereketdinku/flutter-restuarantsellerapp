import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/services/store_services.dart';
import 'package:seller_app/views/messages/chat.dart';
import 'package:seller_app/widgets/loading_indicator.dart';
import 'package:seller_app/widgets/text_stryle.dart';
import 'package:intl/intl.dart' as intl;

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: darkgrey,
              )),
          title: boldText(text: messages, size: 16.0, color: fontGrey),
        ),
        body: StreamBuilder(
          stream: StoreServices.getMessages(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var t = data[index]['created_on'] == null
                          ? DateTime.now()
                          : data[index]['created_on'].toDate();
                      var time = intl.DateFormat("h:ma").format(t);
                      return ListTile(
                        onTap: () {
                          Get.to(() => ChatScreen());
                        },
                        leading: const CircleAvatar(
                            backgroundColor: purpleColor,
                            child: Icon(
                              Icons.person,
                              color: white,
                            )),
                        title: boldText(
                            text: "${data[index]['sender_name']}",
                            color: fontGrey),
                        subtitle: normaltext(
                            text: "${data[index]['last_msg']}",
                            color: darkgrey),
                        trailing: normaltext(text: "10:45PM", color: darkgrey),
                      );
                    }),
                  ),
                ),
              );
            }
          },
        ));
  }
}
