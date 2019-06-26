import 'package:quizapp/models/models.dart';

class User {
  String uid;
  DateTime dateCreated;
  DateTime dateOfBirth;
  String firstName;
  String lastName;
  Weight goalWeight;
  Height height;
  List<Question> questions;

  User({this.uid, this.questions});

  factory User.fromMap(Map data) {
    return User(
        uid: data['uid'],
        questions: (data['questions'] as List ?? [])
            .map((v) => Question.fromMap(v))
            .toList());
  }
}

class Weight {
  double weight;
  WeightUoM uom;

  Weight({this.uom, this.weight});
  factory Weight.fromMap(Map data) {
    return Weight(
      weight: data['weight'] ?? 0,
      uom: data['uom'] ?? 0,
    );
  }
}
enum WeightUoM { kg, lb }

class Height {
  double height;
  HeightUoM uom;

  Height({this.uom, this.height});
  factory Height.fromMap(Map data) {
    return Height(
      height: data['height'] ?? 0,
      uom: data['uom'] ?? 0,
    );
  }
}

enum HeightUoM { m, inches }
