import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/services/firestore_services.dart';
import 'package:new_e_mart/views/chat_screen/components/sender_bubble.dart';
import 'package:new_e_mart/widgets_common/lodingIndicator.dart';
import '../../controllers/chats_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: "${controller.friendName}"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          Obx(
            () => controller.isLoading.value
                ? Center(
                    child: loadingIndicator(),
                  )
                : Expanded(
                    child: StreamBuilder(
                        stream: FirestoreServices.getChatMsg(
                            controller.chatDocId.toString()),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: loadingIndicator(),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Container(
                              child: "Send a message"
                                  .text
                                  .color(darkFontGrey)
                                  .make(),
                            );
                          } else {
                            return ListView(
                              children: snapshot.data!.docs
                                  .mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];

                                return Align(
                                    alignment: data['uid'] == currentUser!.uid
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: senderBubble(data));
                              }).toList(),
                            );
                          }
                        })),
          ),
          10.heightBox,
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: controller.msgController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: textfieldGrey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: textfieldGrey)),
                  hintText: "Type a message...",
                ),
              )),
              IconButton(
                  onPressed: () {
                    controller.sendMsg(controller.msgController.text);
                    controller.msgController.clear();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: redColor,
                  ))
            ],
          )
              .box
              .height(60)
              .padding(const EdgeInsets.all(8))
              .margin(const EdgeInsets.only(bottom: 8))
              .make()
        ]),
      ),
    );
  }
}
