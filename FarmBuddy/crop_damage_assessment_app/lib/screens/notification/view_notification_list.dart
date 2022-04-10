import 'package:crop_damage_assessment_app/models/notification_model.dart';
import 'package:crop_damage_assessment_app/models/user.dart';
import 'package:crop_damage_assessment_app/screens/notification/notification_tile.dart';
import 'package:crop_damage_assessment_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:crop_damage_assessment_app/components/loading.dart';
import 'package:crop_damage_assessment_app/screens/farmer/home/claim_tile.dart';

class ViewNotificationList extends StatefulWidget {
  const ViewNotificationList({Key? key, required this.uid, required this.notification_list}) : super(key: key);

  final String? uid;
  final List<NotificationModel> notification_list;

  @override
  _ViewNotificationListState createState() => _ViewNotificationListState();
}

class _ViewNotificationListState extends State<ViewNotificationList> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    

    return loading
        ? const Loading()
        : Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: 

            Column(
              children: <Widget>[
                const SizedBox(height: 40.0),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Notifications",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          color: Color.fromARGB(255, 80, 79, 79)),
                    )
                  ),

                const SizedBox(height: 30.0),

                widget.notification_list.isNotEmpty? 
                  ListView.builder(
                    itemCount: widget.notification_list.length,
                    itemBuilder: (context, index) {
                      return NotificationTile(notification: widget.notification_list[index]);
                    },
                  )
                : const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Empty",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Color.fromARGB(255, 80, 79, 79)),
                    ))
                ],

            ),
            
            
              );
  }
}
