import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_plans/models/plan_model.dart';
import 'package:my_plans/services/pref_service.dart';
import 'package:my_plans/services/rtdb_service.dart';
import 'package:my_plans/services/util_service.dart';

import 'detail_page.dart';

class PlansPage extends StatefulWidget {

  static final String id = 'plans_page';

  @override
  _PlansPageState createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {

  List<Plan> _planList = new List();
  Query _planQuery;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  StreamSubscription<Event> _onPlanAddedSubscription;
  StreamSubscription<Event> _onPlanChangedSubscription;

  @override
  void initState() {
    super.initState();
    _apiLoadStore();
  }

  onEntryChanged(Event event) {
    var oldEntry = _planList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _planList[_planList.indexOf(oldEntry)] =
          Plan.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _planList.add(Plan.fromSnapshot(event.snapshot));
    });
  }

  _apiLoadStore() async {
    var _id = await Prefs.loadUserId();

    _planQuery = _database.reference().child("plan").orderByChild("userId").equalTo(_id);
    _onPlanAddedSubscription = _planQuery.onChildAdded.listen(onEntryAdded);
    _onPlanChangedSubscription = _planQuery.onChildChanged.listen(onEntryChanged);
  }

  Future _openDetailPage() async {
    Map result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return new DetailPage();
        }
    ));

    if(result != null && result.containsKey('data')) {
      print(result['data']);
    }
  }

  @override
  void dispose() {
    _onPlanAddedSubscription.cancel();
    _onPlanChangedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showPlanList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        onPressed: _openDetailPage,
      ),
    );
  }

  Widget showPlanList() {
    if(_planList.length > 0) {
      return ListView.builder(
        itemCount: _planList.length,
        itemBuilder: (ctx, i) {
          return Dismissible(
            key: UniqueKey(),//Key(_planList[i].userId),
            background: Container(color: Colors.red),
            onDismissed: (direction) async {
              RTDBService.deletePlan(_planList[i], i).then((value) => {
                setState(() {
                  _planList.removeAt(i);
                })
              });
            },
            child: _itemOfList(_planList[i]),
          );
        },
      );
    } else {
      return Center(
          child: Text(
            "Welcome. Your list is empty",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0),
          ));
    }
  }

  Widget _itemOfList(Plan plan) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: double.infinity,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
          color: Colors.white,
        ),
        child: ListTile(
          title: Text(
            plan.title,
            style: TextStyle(fontSize: 20.0),
          ),
          leading: Container(
            height: 70,
            width: 70,
            child: plan.imgUrl != null ?
            Image.network(plan.imgUrl,fit: BoxFit.cover,):
            Image.asset("assets/images/placeholder.jpg"),
          ),
          subtitle: Text(plan.content + '\n' + plan.date),
          isThreeLine: true,
          trailing: IconButton(
              icon: (plan.completed)
                  ? Icon(
                Icons.done_outline,
                color: Colors.green,
                size: 20.0,
              )
                  : Icon(Icons.done, color: Colors.grey, size: 20.0),
              onPressed: () {
                RTDBService.updatePlan(plan);
              }),
          onTap: () {
            Utils.showDialogWithImage(context, plan);
          },
        ),
      )
    );
  }
}
