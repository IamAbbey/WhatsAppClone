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

