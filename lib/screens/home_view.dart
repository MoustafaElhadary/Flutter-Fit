import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/models/models.dart';
import 'package:quizapp/services/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  String pageName = "";

  List<Topic> _topics = new List<Topic>();
  final TopicsScreen _topicScreen = new TopicsScreen();
  final ProfileScreen _profileScreen = new ProfileScreen();
  final WorkoutsScreen _workoutsScreen = new WorkoutsScreen();
  final NotificationsView _notificationsView = new NotificationsView();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    new Future.delayed(Duration.zero, () {
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
        return new Container(
          child: new Center(
              child: new Text('No page found by page chooser.',
                  style: new TextStyle(fontSize: 30.0))),
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
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(pageName ?? "", style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.black),),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
         value: SystemUiOverlayStyle.light,                
         child: pageChooser(),
      ),
      drawer: new TopicDrawer(topics: _topics),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
        
          new BottomNavigationBarItem(
            icon: new Icon(Icons.fitness_center),
            title: new Text('Workout'),
          ),new BottomNavigationBarItem(
            icon: new Icon(Icons.chat),
            title: new Text('Chat'),
          ),
          new BottomNavigationBarItem(
            icon: (user == null || user.photoUrl == null)
                ? Icon(
                    FontAwesomeIcons.userCircle,
                  )
                : Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(blurRadius: pageIndex == 1 ? 3 : 0)
                      ],
                      image: DecorationImage(
                        image: NetworkImage(user.photoUrl),
                      ),
                    ),
                  ),
            title: new Text('Me'),
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
