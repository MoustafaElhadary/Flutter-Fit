import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:quizapp/models/models.dart';

import 'services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


/// Static global state. Immutable services that do not care about build context. 
class Global {
  // App Data
  static final String title = 'The Moustafa Quiz';

  // Services
  static final FirebaseAnalytics analytics = FirebaseAnalytics();
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  static final Messages messages = Messages();
    // Data Models
  static final Map models = {
    Topic: (data) => Topic.fromMap(data),
    Quiz: (data) => Quiz.fromMap(data),
    Report: (data) => Report.fromMap(data),
    Message: (data) => Message.fromMap(data)
  };

  // Firestore References for Writes
  static final Collection<Topic> topicsRef = Collection<Topic>(path: 'topics');
  static final UserData<Report> reportRef = UserData<Report>(collection: 'reports'); 

  
}
