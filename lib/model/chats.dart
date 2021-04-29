import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == this.day &&
        now.month == this.month &&
        now.year == this.year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return yesterday.day == this.day &&
        yesterday.month == this.month &&
        yesterday.year == this.year;
  }
}

class Chat {
  String name;
  String imageURL;
  DateTime dateTime;
  String lastMessage;
  bool isPinned;
  bool isRead;
  bool isSentMessage;
  List<ChatMessage> chatMessages = [];

  Chat({
    @required this.name,
    this.imageURL,
    @required this.dateTime,
    @required this.lastMessage,
    this.isPinned = false,
    this.isRead = true,
    this.isSentMessage = false,
    this.chatMessages,
  });

  String getFormattedTime() {
    // return DateFormat.jm().format(this.dateTime);
    if (this.dateTime.isYesterday()) {
      return 'Yesterday';
    } else if (this.dateTime.isToday()) {
      return DateFormat.jm().format(this.dateTime);
    } else {
      return DateFormat.yMd().format(this.dateTime);
    }
  }
}

class ChatMessage {
  String message;
  DateTime dateTime;
  String imageURL;
  bool isRead;
  bool isSentMessage;

  ChatMessage({
    @required this.message,
    @required this.dateTime,
    this.imageURL,
    this.isRead = true,
    this.isSentMessage = true,
  });

  String getFormattedTime({bool timeOnly}) {
    // return DateFormat.jm().format(this.dateTime);
    if (this.dateTime.isYesterday()) {
      return 'Yesterday';
    } else if (timeOnly || this.dateTime.isToday()) {
      return DateFormat.jm().format(this.dateTime);
    } else {
      return DateFormat.yMd().format(this.dateTime);
    }
  }
}

class Status {
  String name;
  String imageURL;
  bool viewed;
  DateTime dateTime;

  Status({
    @required this.name,
    @required this.dateTime,
    this.imageURL,
    this.viewed = true,
  });

  String getFormattedTime() {
    // return DateFormat.jm().format(this.dateTime);
    if (this.dateTime.isYesterday()) {
      return 'Yesterday';
    } else if (this.dateTime.isToday()) {
      return DateFormat.jm().format(this.dateTime);
    } else {
      return DateFormat.yMd().format(this.dateTime);
    }
  }
}

class CallHistory {
  String name;
  String imageURL;
  bool isVideoCall;
  bool isIncomingCall;
  DateTime dateTime;

  CallHistory({
    @required this.name,
    @required this.dateTime,
    this.imageURL,
    this.isVideoCall = false,
    this.isIncomingCall = true,
  });

  String getFormattedTime() {
    // return DateFormat.jm().format(this.dateTime);
    if (this.dateTime.isYesterday()) {
      return 'Yesterday';
    } else if (this.dateTime.isToday()) {
      return DateFormat.jm().format(this.dateTime);
    } else {
      return DateFormat.yMd().format(this.dateTime);
    }
  }
}

final faker = new Faker();

List<ChatMessage> chatMessageList = List.generate(
  20,
  (index) => ChatMessage(
    message: faker.lorem.sentences(2).join('\n'),
    dateTime: faker.date.dateTime(minYear: 2021, maxYear: 2021),
    imageURL: index % 5 == 0
        ? faker.image.image(keywords: ['people', 'nature'], random: true)
        : null,
    isSentMessage: faker.randomGenerator.boolean(),
  ),
);

List<Status> statusList = List.generate(
  20,
  (index) => Status(
    name: faker.person.name(),
    dateTime: faker.date.dateTime(minYear: 2021, maxYear: 2021),
    imageURL: faker.image
        .image(keywords: ['people', 'nature', 'sport'], random: true),
    viewed: faker.randomGenerator.boolean(),
  ),
);

List<CallHistory> callHistoryList = List.generate(
  20,
  (index) => CallHistory(
    name: faker.person.name(),
    dateTime: faker.date.dateTime(minYear: 2021, maxYear: 2021),
    imageURL: faker.image.image(keywords: ['people'], random: true),
    isVideoCall: faker.randomGenerator.boolean(),
    isIncomingCall: faker.randomGenerator.boolean(),
  ),
);

List<Chat> chatList = List.generate(
  20,
  (index) => Chat(
    name: faker.person.name(),
    lastMessage: faker.lorem.sentences(index % 3 == 0 ? 4 : 2).join(' '),
    dateTime: faker.date.dateTime(minYear: 2021, maxYear: 2021),
    imageURL: faker.image.image(keywords: ['people'], random: true),
    isPinned: faker.randomGenerator.boolean(),
    isSentMessage: faker.randomGenerator.boolean(),
    isRead: faker.randomGenerator.boolean(),
    chatMessages: chatMessageList,
  ),
);

// List<ChatMessage> chatMessageList = [
//   ChatMessage(
//     message: faker.lorem.sentences(2).join('\n'),
//     dateTime: faker.date.dateTime(minYear: 2000, maxYear: 2020),
//     imageURL: faker.image.image(keywords: ['people']),
//   ),
//   ChatMessage(
//     message: faker.lorem.sentences(2).join('\n'),
//     dateTime: faker.date.dateTime(minYear: 2000, maxYear: 2020),
//   ),
//   ChatMessage(
//     message: 'lorem ipsum',
//     dateTime: DateTime.now().subtract(Duration(hours: 1)),
//   ),
//   ChatMessage(
//     message: 'lorem ipsum',
//     dateTime: DateTime.now().subtract(Duration(hours: 3)),
//     isSentMessage: false,
//   ),
//   ChatMessage(
//     message: 'lorem ipsum',
//     dateTime: DateTime.now().subtract(Duration(hours: 2)),
//   ),
//   ChatMessage(
//     message:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
//     dateTime: DateTime.now().subtract(Duration(hours: 2)),
//     isSentMessage: false,
//   ),
//   ChatMessage(
//     message:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
//     imageURL:
//         'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=934&q=80',
//     dateTime: DateTime.now().subtract(Duration(hours: 1)),
//   ),
//   ChatMessage(
//     message: 'lorem ipsum',
//     dateTime: DateTime.now().subtract(Duration(hours: 2)),
//   ),
//   ChatMessage(
//     message:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
//     dateTime: DateTime.now().subtract(Duration(hours: 0)),
//   ),
//   ChatMessage(
//     message: 'lorem ipsum',
//     dateTime: DateTime.now().subtract(Duration(hours: 2)),
//   ),
// ];

// List<Chat> chatList = [
//   Chat(
//     name: 'Johnson Duane',
//     imageURL:
//         'https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
//     dateTime: DateTime.now().subtract(Duration(hours: 2)),
//     lastMessage: 'lorem Ipsum',
//     isPinned: false,
//     isSentMessage: true,
//     chatMessages: chatMessageList,
//   ),
//   Chat(
//     name: 'Abiodun',
//     imageURL:
//         'https://ca.slack-edge.com/T03C58ZBF-U01CVBK63NY-59bf03ab39f7-512',
//     dateTime: DateTime.now(),
//     lastMessage: 'lorem Ipsum',
//     isPinned: false,
//     isRead: false,
//     chatMessages: chatMessageList,
//   ),
//   Chat(
//     name: 'Joyce Love',
//     imageURL:
//         'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=934&q=80',
//     dateTime: DateTime.now(),
//     lastMessage: 'lorem Ipsum',
//     isPinned: false,
//     isSentMessage: true,
//     chatMessages: chatMessageList,
//   ),
//   Chat(
//     name: 'Daniel Finch',
//     imageURL:
//         'https://images.unsplash.com/photo-1497316730643-415fac54a2af?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
//     dateTime: DateTime.now().subtract(Duration(hours: 3)),
//     lastMessage: 'lorem Ipsum',
//     isPinned: true,
//     chatMessages: chatMessageList,
//   ),
//   Chat(
//     name: 'Kim Jong',
//     dateTime: DateTime.now(),
//     lastMessage:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
//     isRead: false,
//     chatMessages: chatMessageList,
//   ),
//   Chat(
//     name: 'Mary Sloane',
//     imageURL:
//         'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=3265&q=80',
//     dateTime: DateTime.now(),
//     lastMessage: 'lorem Ipsum',
//     isPinned: false,
//     chatMessages: chatMessageList,
//   ),
// ];
