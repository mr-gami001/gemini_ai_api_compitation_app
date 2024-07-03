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
            Expanded(
              child: BlocConsumer(
                bloc: chatBloc,
                builder: (context, state) {
                  if (state is SucessState) {
                    chatList = state.chatList;
                    return ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemBuilder: (context, index) =>
                          messageTile(state.chatList[index]),
                      itemCount: state.chatList.length,
                    );
                  }
                  return const Center(
                    child: Text("Try Now Chat GPT..."),
                  );
                },
                listener: (context, state) {},
              ),
            ),
            TextField(
              controller: controller,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  // fillColor: Colors.black45,
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  hintText: "Message To GPT ....",
                  suffix: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          chatBloc.add(SendToAIEvent(controller.text));
                          controller.clear();
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        }
                      },
                      icon: const Icon(Icons.send))),
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
            )
          ],
        ),
      ),
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
