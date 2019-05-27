import 'package:flutter/material.dart';

@immutable
class Message {
  String title;
  String body;

  Message({
    @required this.title,
    @required this.body,
  });
  Message.fromMap(Map data) {
    title = data['title'] ?? '';
    body = data['body'] ?? '';
  }
}

class Messages with ChangeNotifier {
  List<Message> _messages = [];

  Messages();

  List<Message> get getMesssages => _messages;
  set setMessages(List<Message> messages){
    _messages= messages;
    notifyListeners();
  }
  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }
}
