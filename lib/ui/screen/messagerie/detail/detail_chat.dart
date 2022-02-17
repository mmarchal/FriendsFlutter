import 'package:flutter/material.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/chat.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/model/message.dart';
import 'package:life_friends/notifier/chat/chat_list_notifier.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/service/chat.repository.dart';
import 'package:provider/src/provider.dart';

class DetailChat extends StatefulWidget {
  final Chat chat;

  const DetailChat({Key? key, required this.chat}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DetailChatState();
  }
}

class DetailChatState extends State<DetailChat> {
  final TextEditingController messageController = TextEditingController();

  // ignore: prefer_final_fields
  List<Message>? _list;

  @override
  void initState() {
    if (widget.chat.messagesList != null) {
      _list = [];
      _list!.addAll(widget.chat.messagesList!.toList());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Friend connected = context.watch<FriendNotifier>().friend!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const CircleAvatar(
                  child: Icon(Icons.message),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.chat.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                          hintText: "Ecrire un message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      String content = messageController.text;
                      messageController.clear();
                      Message newMessage = Message(
                        content: content,
                        deliveredAt: DateTime.now(),
                        friend: connected,
                      );
                      setState(() {
                        _list!.add(newMessage);
                      });
                      APIResponse<bool> sendMessage =
                          await Provider.of<ChatRepository>(context,
                                  listen: false)
                              .createMessageByChannelId(
                        channelId: widget.chat.id.toString(),
                        message: newMessage,
                      );
                      Provider.of<ChatListNotifier>(context, listen: false)
                          .loadChannels(
                              friendId: Provider.of<FriendNotifier>(context,
                                      listen: false)
                                  .friend!
                                  .id!
                                  .toString(),
                              clearList: true);
                    },
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
          (_list != null)
              ? ListView.builder(
                  itemCount: _list!.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Message m = _list![index];
                    return Container(
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (m.friend.id != connected.id
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (m.friend.id != connected.id
                                ? Colors.grey.shade200
                                : Colors.blue[200]),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            m.content,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text(
                    "Aucun message dans cette conversation",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                )
        ],
      ),
    );
  }
}