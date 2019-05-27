import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizapp/models/models.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import '../screens/screens.dart';

class TopicsScreen extends StatelfulPageBase {
  final String pageTitle = "Workouts";
  TopicsScreen() : super();

  @override
  _TopicsScreenState createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen>
    with AutomaticKeepAliveClientMixin<TopicsScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Global.topicsRef.getData(),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.hasData) {
          List<Topic> topics = snap.data;
          return ListView.builder(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              shrinkWrap: true,
              itemCount: topics.length,
              itemBuilder: (BuildContext context, int idx) {
                return TopicItem(
                  topic: topics[idx],
                );
              });
        } else {
          return LoadingScreen();
        }
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({Key key, this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: topic.img,
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          return SingleChildScrollView(
            child: fromHeroContext.widget,
          );
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => TopicScreen(topic: topic),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/covers/${topic.img}',
                  fit: BoxFit.contain,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          topic.title,
                          style: TextStyle(
                              height: 1.5, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                    ),
                    // Text(topic.description)
                  ],
                ),
                // )
                TopicProgress(topic: topic),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopicScreen extends StatelessWidget {
  final Topic topic;

  TopicScreen({this.topic});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.blue, //or set color with: Color(0xFF0000FF)
    ));
    return Scaffold(
      appBar: AppBar(
          title: Text(
            topic.title,
          ),
          backgroundColor: Colors.deepOrange),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Hero(
            tag: topic.img,
            flightShuttleBuilder: (
              BuildContext flightContext,
              Animation<double> animation,
              HeroFlightDirection flightDirection,
              BuildContext fromHeroContext,
              BuildContext toHeroContext,
            ) {
              return SingleChildScrollView(
                child: fromHeroContext.widget,
              );
            },
            child: Image.asset('assets/covers/${topic.img}',
                width: MediaQuery.of(context).size.width),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              topic.title,
              style: TextStyle(
                  height: 2, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          QuizList(topic: topic)
        ],
      ),
    );
  }
}

class QuizList extends StatelessWidget {
  final Topic topic;
  QuizList({Key key, this.topic});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: topic.quizzes.map((quiz) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        elevation: 4,
        margin: EdgeInsets.all(4),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => QuizScreen(quizId: quiz.id),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                quiz.title,
                style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(
                quiz.description,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.subhead,
              ),
              leading: QuizBadge(topic: topic, quizId: quiz.id),
            ),
          ),
        ),
      );
    }).toList());
  }
}