import 'package:firebase_database/firebase_database.dart';
import 'package:my_plans/models/plan_model.dart';

class RTDBService {
  static final FirebaseDatabase _database = FirebaseDatabase.instance;

  static Future<Stream<Event>> addNewPlan(Plan plan) async {
    if (plan.content.isNotEmpty || plan.title.isNotEmpty || plan.date.isNotEmpty) {
      _database.reference().child("plan").push().set(plan.toJson());
      return _database.reference().onChildAdded;
    } else {
      return null;
    }
  }


  static Future<Stream<Event>> updatePlan(Plan plan) async {
    plan.completed = !plan.completed;
    if (plan != null) {
      _database.reference().child("plan").child(plan.key).set(plan.toJson());
    }
    return _database.reference().onChildChanged;
  }

  static Future<Stream<Event>> deletePlan(Plan plan, int index) async {
    _database.reference().child("plan").child(plan.key).remove().then((_) {
      print("Delete ${plan.userId} successful");
    });
    return _database.reference().onChildRemoved;
  }
}