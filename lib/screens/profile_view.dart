import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizapp/models/models.dart';
import 'package:quizapp/screens/screens.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessPageBase {
  final AuthService auth = AuthService();
  @override
  // TODO: implement pageTitle
  String get pageTitle => super.pageTitle;

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    if (user != null) {
      pageTitle = user.displayName;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (user.photoUrl != null)
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user.photoUrl),
                  ),
                ),
              ),
            Text(user.email ?? '', style: Theme.of(context).textTheme.headline),
            Container(
              width: 300,
              height: 300,
                child: AspectRatio(
              child: FlareActor(
                'assets/Success.flr',
                animation: 'check-success',
              ),
              aspectRatio: 1,
            )),
            if (report != null)
              Text('${report.total ?? 0}',
                  style: Theme.of(context).textTheme.display3),
            Text('Quizzes Completed',
                style: Theme.of(context).textTheme.subhead),
            FlatButton(
                child: Text('logout'),
                color: Colors.red,
                onPressed: () async {
                  await auth.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                }),
          ],
        ),
      );
    } else {
      return LoadingScreen();
    }
  }
}
