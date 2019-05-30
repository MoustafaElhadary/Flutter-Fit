import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
