import 'package:fitness_coach_app/models/app_landing/dependecy_inject.dart';
import 'package:fitness_coach_app/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_bloc.dart';
import 'message_dm.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatBloc chatBloc = ChatBloc([]);
  List<MessageDm> chatList = [];
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    chatBloc.add(InitEvent());
    chatList = chatBloc.chatList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
        ),
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.3,
        child: Column(
          children: [
            // AppBar(
            //   ,
            //   centerTitle: true,
            //   title: ,
            // ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.purpleAccent,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    alignment: Alignment.center,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Center(child: Text("Chat Bot")),
                  const SizedBox()
                ],
              ),
            ),

            BlocConsumer(
              bloc: chatBloc,
              builder: (context, state) {
                if (state is SucessState) {
                  chatList = state.chatList;
                  return Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemBuilder: (context, index) =>
                          messageTile(state.chatList[index]),
                      itemCount: state.chatList.length,
                    ),
                  );
                }
                return const Expanded(
                    child: Center(
                  child: Text("Try Now Chat GPT..."),
                ));
              },
              listener: (context, state) {},
            ),
            BlocBuilder(
                bloc: chatBloc,
                builder: (context, state) {
                  if (state is SucessState) {
                    return bottomRow(state.isLoading);
                  }
                  return bottomRow(false);
                })
          ],
        ),
      ),
    );
  }

  Widget bottomRow(bool isLoading) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            textAlignVertical: TextAlignVertical.center,
            cursorHeight: 10,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
                gapPadding: 0,
              ),
              // fillColor: Colors.black45,
              filled: true,
              isCollapsed: true,
              contentPadding:
                  const EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 15),
              hintText: "Message To GPT ....",
              hintStyle: getIt<AppTextStyle>().mukta15pxnormalBlack,
            ),
            textAlign: TextAlign.left,
            keyboardAppearance: Brightness.light,
            keyboardType: TextInputType.text,
            enableSuggestions: true,
            textInputAction: TextInputAction.send,
            onSubmitted: (val) {
              if (val.isNotEmpty) {
                chatBloc.add(SendToAIEvent(controller.text));
                controller.clear();
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                // scrollController
                //     .jumpTo(scrollController.position.maxScrollExtent);
              }
            },
          ),
        ),
        isLoading == false
            ? InkWell(
                onTap: () {
                  if (controller.text.isNotEmpty) {
                    chatBloc.add(SendToAIEvent(controller.text));
                    controller.clear();
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                  }
                },
                child: const Padding(
                    padding: EdgeInsets.only(left: 10, right: 15),
                    child: Icon(Icons.send)),
              )
            : const Padding(
                padding: EdgeInsets.only(
                  right: 5,
                  left: 5,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.black,
                    ),
                    Center(
                      child: SizedBox(
                        height: 27,
                        width: 27,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.stop,
                      color: Colors.white,
                    )
                  ],
                ),
              )
      ],
    );
  }

  Widget messageTile(MessageDm message) {
    return Container(
      alignment: message.senderType! == SenderType.user
          ? Alignment.centerLeft
          : Alignment.centerRight,
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(message.message ?? ''),
        ),
      ),
    );
  }
}
