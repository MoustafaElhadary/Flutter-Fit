import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/models/models.dart';
import 'package:quizapp/screens/screens.dart';

class createUserCircleInNavBar extends StatelessWidget {
  final FirebaseUser user;
  final int currentPageIndex;
  final int iconIndex;
  createUserCircleInNavBar({Key key, this.user, this.currentPageIndex, this.iconIndex});
  @override
  Widget build(BuildContext context) {
    return (user == null || user.photoUrl == null)
        ? Icon(
            FontAwesomeIcons.userCircle,
                          color: currentPageIndex == iconIndex ? Colors.black : Colors.grey,
          )
        : Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(blurRadius: currentPageIndex == iconIndex ? 3 : 0)],
              image: DecorationImage(
                image: NetworkImage(user.photoUrl),
              ),
            ),
          );
  }
}

class CustomDrawer extends StatelessWidget {
  final List<Topic> topics;
  CustomDrawer({Key key, this.topics});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.separated(
          shrinkWrap: true,
          itemCount: topics.length,
          itemBuilder: (BuildContext context, int idx) {
            Topic topic = topics[idx];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    topic.title,
                    // textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                QuizList(topic: topic)
              ],
            );
          },
          separatorBuilder: (BuildContext context, int idx) => Divider()),
    );
  }
}

