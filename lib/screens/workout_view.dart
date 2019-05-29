import 'package:flutter/material.dart';
import 'package:quizapp/screens/screens.dart';

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
    return Container(
      child: ListView(
        children: <Widget>[
          WorkoutCard(),
          WorkoutCard(),
          WorkoutCard(),
          WorkoutCard(),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({
    Key key,
  }) : super(key: key);

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
                child: Image.network(
                  'https://placeimg.com/640/480/any',
                  fit: BoxFit.cover,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: EdgeInsets.all(10),
            ),
          ),
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
          )
        ],
      ),
    );
  }
}
