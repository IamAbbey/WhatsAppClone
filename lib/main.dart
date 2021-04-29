import 'dart:io';

import 'package:WhatsappClone/constants.dart';
import 'package:WhatsappClone/model/chats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'WhatsApp',
            theme: kLightTheme,
            home: MyHomePage(),
          )
        : CupertinoApp();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    chatList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    chatList.sort((a, b) => b.isPinned ? 1 : -1);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('WhatsApp'),
          bottom: TabBar(
            indicatorColor: kWhiteColor,
            tabs: [
              Tab(icon: Icon(Icons.camera_alt)),
              Tab(text: 'CHATS'),
              Tab(text: 'STATUS'),
              Tab(text: 'CALLS'),
            ],
          ),
          actions: [
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
            IconButton(icon: Icon(Icons.more_vert_outlined), onPressed: () {}),
          ],
        ),
        body: TabBarView(
          children: [
            IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
            ChatScreen(),
            StatusScreen(),
            CallHistoryScreen()
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          indent: 60,
          endIndent: 20,
          height: 0,
        ),
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          final chat = chatList[index];
          return ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetail(
                    chat: chat,
                  ),
                )),
            dense: true,
            leading: chat.imageURL != null
                ? CircleAvatar(backgroundImage: NetworkImage(chat.imageURL))
                : CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      color: kWhiteColor,
                    ),
                  ),
            title: Text(chat.name),
            subtitle: Row(
              children: [
                chat.isSentMessage
                    ? Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Icon(
                          Icons.done_all,
                          color: Colors.grey[500],
                          size: 14,
                        ),
                      )
                    : Container(),
                Expanded(
                    child: Text(
                  chat.lastMessage,
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            ),
            trailing: SizedBox(
              width: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    chat.getFormattedTime(),
                    style: TextStyle(fontSize: 10.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      chat.isPinned
                          ? Padding(
                              padding: chat.isRead
                                  ? EdgeInsets.zero
                                  : const EdgeInsets.only(right: 4.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[400],
                                foregroundColor: kWhiteColor,
                                radius: 8,
                                child: Transform.rotate(
                                  angle: math.pi / 4,
                                  child: Icon(
                                    Icons.push_pin_rounded,
                                    size: 11,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      chat.isRead
                          ? Container()
                          : CircleAvatar(
                              backgroundColor: kPrimaryLightColor,
                              radius: 8,
                              child: Text(
                                '1',
                                style:
                                    TextStyle(color: kWhiteColor, fontSize: 10),
                              ),
                            ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Contacts',
        child: Icon(Icons.chat),
      ),
    );
  }
}

class ChatDetail extends StatefulWidget {
  final Chat chat;
  const ChatDetail({Key key, @required this.chat}) : super(key: key);

  @override
  _ChatDetailState createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  @override
  void initState() {
    super.initState();
    widget.chat.chatMessages.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.chat.imageURL != null
                ? CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(widget.chat.imageURL),
                  )
                : CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      color: kWhiteColor,
                    ),
                  ),
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Text(
                widget.chat.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: kWhiteColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
          IconButton(icon: Icon(Icons.call), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert_outlined), onPressed: () {}),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              'https://thepracticaldev.s3.amazonaws.com/i/tw0nawnvo0zpgm5nx4fp.png',
            ),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.chat.chatMessages.length,
                itemBuilder: (context, index) {
                  final chatMessage = widget.chat.chatMessages[index];
                  return Align(
                    alignment: chatMessage.isSentMessage
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: chatMessage.isSentMessage
                            ? kWhiteColor
                            : kOutgoingMessageBubbleColor,
                      ),
                      margin: chatMessage.isSentMessage
                          ? EdgeInsets.only(left: 4.0, right: 48.0, bottom: 4.0)
                          : EdgeInsets.only(
                              right: 4.0, left: 48.0, bottom: 4.0),
                      padding: EdgeInsets.all(3.0),
                      child: chatMessage.imageURL != null
                          ? Image.network(
                              chatMessage.imageURL,
                              fit: BoxFit.cover,
                              height: 200,
                              width: 200,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(chatMessage.message),
                                  Text(
                                    chatMessage.getFormattedTime(
                                        timeOnly: true),
                                    style: TextStyle(fontSize: 10),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: kWhiteColor),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.tag_faces_outlined,
                              color: Colors.grey[500],
                            ),
                            onPressed: () {},
                          ),
                          Flexible(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Type a message',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Transform.rotate(
                            angle: -math.pi / 4,
                            child: IconButton(
                              icon: Icon(
                                Icons.attach_file,
                                color: Colors.grey[500],
                              ),
                              onPressed: () {},
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.camera_alt),
                            color: Colors.grey[600],
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    foregroundColor: kWhiteColor,
                    child: IconButton(icon: Icon(Icons.mic), onPressed: () {}),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key key}) : super(key: key);

  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  void initState() {
    super.initState();
    statusList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 0,
          indent: 60,
          endIndent: 20,
        ),
        itemCount: statusList.length,
        itemBuilder: (context, index) {
          final status = statusList[index];
          if (index == 0) {
            return ListTile(
              onTap: () {},
              dense: true,
              leading: status.imageURL != null
                  ? CircleAvatar(backgroundImage: NetworkImage(status.imageURL))
                  : CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.error,
                        color: kWhiteColor,
                      ),
                    ),
              title: Text('My Status'),
              subtitle: Text(
                status.getFormattedTime(),
                style: Theme.of(context).textTheme.caption,
              ),
              trailing: Icon(
                Icons.more_horiz_outlined,
                color: kPrimaryColor,
              ),
            );
          }
          return index == 1
              ? Container(
                  color: Colors.grey[200],
                  padding: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 16.0),
                  child: Text(
                    'Recent updates',
                    style: Theme.of(context).textTheme.caption,
                  ),
                )
              : ListTile(
                  onTap: () {},
                  dense: true,
                  leading: status.imageURL != null
                      ? Container(
                          padding: EdgeInsets.all(1.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: status.viewed
                                ? Colors.grey[400]
                                : kPrimaryColor,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: kWhiteColor,
                            ),
                            padding: EdgeInsets.all(1.5),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(status.imageURL),
                            ),
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Icon(
                            Icons.error,
                            color: kWhiteColor,
                          ),
                        ),
                  title: Text(status.name),
                  subtitle: Text(
                    status.getFormattedTime(),
                    style: Theme.of(context).textTheme.caption,
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Camera',
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}

class CallHistoryScreen extends StatefulWidget {
  CallHistoryScreen({Key key}) : super(key: key);

  @override
  _CallHistoryScreenState createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends State<CallHistoryScreen> {
  @override
  void initState() {
    super.initState();
    callHistoryList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 0,
          indent: 60,
          endIndent: 20,
        ),
        itemCount: callHistoryList.length,
        itemBuilder: (context, index) {
          final callHistory = callHistoryList[index];
          return ListTile(
            dense: true,
            leading: callHistory.imageURL != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(callHistory.imageURL),
                  )
                : CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.error,
                      color: kWhiteColor,
                    ),
                  ),
            title: Text(callHistory.name),
            subtitle: Row(
              children: [
                callHistory.isIncomingCall
                    ? Icon(
                        Icons.call_received,
                        color: Colors.red,
                        size: 15,
                      )
                    : Icon(
                        Icons.call_made,
                        color: kPrimaryColor,
                        size: 15,
                      ),
                SizedBox(
                  width: 4.0,
                ),
                Expanded(
                  child: Text(
                    callHistory.getFormattedTime(),
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
            ),
            trailing: callHistory.isVideoCall
                ? Icon(
                    Icons.videocam,
                    color: kPrimaryColor,
                  )
                : Icon(
                    Icons.call,
                    color: kPrimaryColor,
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Call',
        child: Icon(Icons.call),
      ),
    );
  }
}
