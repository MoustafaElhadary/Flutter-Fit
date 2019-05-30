import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/models.dart';
import 'package:quizapp/services/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:quizapp/shared/UI_widgets.dart';

import 'screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  String pageName = "";

  List<Topic> _topics = List<Topic>();
  final TopicsScreen _topicScreen = TopicsScreen();
  final ProfileScreen _profileScreen = ProfileScreen();
  final WorkoutsScreen _workoutsScreen = WorkoutsScreen();
  final NotificationsView _notificationsView = NotificationsView();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    Future.delayed(Duration.zero, () {
      Messages messages = Global.messages;
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          final notification = Message.fromMap(message['notification']);
          messages.addMessage(notification);
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          final notification = Message.fromMap(message['data']);
          messages.addMessage(notification);
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        },
      );
    });
  }

  pageChooser() {
    switch (this.pageIndex) {
      case 0:
        pageName = _topicScreen.pageTitle;
        return _topicScreen;
        break;
      case 1:
        pageName = _workoutsScreen.pageTitle;
        return _workoutsScreen;
        break;
      case 2:
        pageName = _notificationsView.pageTitle;
        return _notificationsView;
        break;
      case 3:
        pageName = _profileScreen.pageTitle;
        return _profileScreen;
        break;

      default:
        return Container(
          child: Center(
              child: Text('No page found by page chooser.',
                  style: TextStyle(fontSize: 30.0))),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    Global.topicsRef.getData().then((topics) {
      setState(() {
        _topics = topics;
      });
    });
    return Scaffold(
      drawer: TopicDrawer(topics: _topics),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0,
        title: Text(
          pageName ?? "",
          style: Theme.of(context).textTheme.headline,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: pageChooser(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: pageIndex == 0 ? Colors.black : Colors.grey,
            ),
            title: Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fitness_center,
              color: pageIndex == 1 ? Colors.black : Colors.grey,
            ),
            title: Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: pageIndex == 2 ? Colors.black : Colors.grey,
            ),
            title: Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: createUserCircleInNavBar(
              user: user,
              currentPageIndex: pageIndex,
              iconIndex: 3
            ),
            title: Container(height: 0.0),
          )
        ],
        currentIndex: pageIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
      ),
    );
  }
}

class TopicDrawer extends StatelessWidget {
  final List<Topic> topics;
  TopicDrawer({Key key, this.topics});

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
