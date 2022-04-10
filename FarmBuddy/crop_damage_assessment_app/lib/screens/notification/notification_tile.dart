import 'dart:async';
import 'package:crop_damage_assessment_app/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
// import 'package:crop_damage_assessment_app/models/notification.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel? notification;

  const NotificationTile({Key? key, required this.notification}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blueGrey.shade900,
                                  child: Text(notification!.avatarIcon),
                                ),
                                title: Row(
                                  children: <Widget>[
                                    Text(notification!.from),
                                    const SizedBox(
                                      width: 16.0,
                                    ),
                                    Text(
                                      notification!.datetime,
                                    ),
                                  ],
                                ),
                                subtitle: Text(notification!.message),
                                tileColor: Colors.amber.shade200,
                                //trailing: ,
                              ),

          ],
        ),
      ),
    );
  }
}
