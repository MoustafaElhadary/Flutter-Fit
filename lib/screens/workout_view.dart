import 'package:flutter/material.dart';
import 'package:quizapp/models/models.dart';
import 'package:quizapp/screens/screens.dart';
import 'package:quizapp/services/services.dart';
import 'package:quizapp/shared/shared.dart';

class WorkoutsScreen extends StatelfulPageBase {
  @override
  String get pageTitle => "Workouts";
  @override
  _WorkoutsScreenState createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen>
    with AutomaticKeepAliveClientMixin<WorkoutsScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Global.topicsRef.getData(),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.hasData) {
          List<Topic> topics = snap.data;
          return ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: topics.length,
              itemBuilder: (BuildContext context, int idx) {
                return WorkoutCard(
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

class WorkoutCard extends StatelessWidget {

   final Topic topic;
  const WorkoutCard({Key key, this.topic}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 10),
      child: Stack(
        children: [
          InkWell(
            onTap: () {},
            child: Card(
              elevation: 4,
              borderOnForeground: false,
              semanticContainer: true,
              clipBehavior: Clip.antiAlias,
              child: Container(
                height: 120,
                width: 420,
                color: Colors.white10,
                // child: Image.network(
                //   'https://placeimg.com/640/480/any',
                //   fit: BoxFit.cover,
                // ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: EdgeInsets.all(10),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                heightFactor: 0.44,
                widthFactor: 1.04,
                child: Container(
                  height: 180,
//            top: -40,
//            right: -MediaQuery.of(context).size.width*.2,
                  child: Image.asset(
                    'assets/fit.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right:16.0),
                child: Column(
                  children: <Widget>[
                    Text(topic.title, style: TextStyle(color: Colors.black),overflow: TextOverflow.ellipsis,),
                    // Text(topic.description, style: Theme.of(context).textTheme.subhead ,overflow: TextOverflow.ellipsis,),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
