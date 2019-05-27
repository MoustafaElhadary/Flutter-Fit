import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/models.dart';
import 'package:quizapp/screens/screens.dart';

class NotificationsView extends StatelessPageBase {
  @override
  // TODO: implement pageTitle
  String get pageTitle => "Notifications";
  @override
  Widget build(BuildContext context) {
    Messages messages = Provider.of<Messages>(context);
    return  messages == null || messages.getMesssages == null
          ? Container(width: 0,height: 0,)
          : ListView(
              children: messages.getMesssages.map(buildMessage).toList(),
            )
    ;
  }

  Widget buildMessage(Message message) => ListTile(
        title: Text(message.title),
        subtitle: Text(message.body),
      );
}
