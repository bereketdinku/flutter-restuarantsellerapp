import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/widgets/text_stryle.dart';

import 'chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
        title: boldText(text: chat, size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: ((context, index) {
                      return chatBubble();
                    }))),
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: "Enter message",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: purpleColor))),
                  )),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      color: purpleColor,
                    ),
                  )
                ],
              ).box.padding(const EdgeInsets.all(12)).make(),
            )
          ],
        ),
      ),
    );
  }
}
