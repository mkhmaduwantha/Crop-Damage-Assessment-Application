import 'dart:async';
import 'package:crop_damage_assessment_app/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
// import 'package:crop_damage_assessment_app/models/notification.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel? notification;

  const NotificationTile({Key? key, required this.notification})
      : super(key: key);

  Icon getStatusIcon(String status) {
    // return const Icon(Icons.circle_notifications,
    //     color: const Color.fromARGB(255, 198, 167, 11), size: 40.0);
    switch (status) {

      case "Approved":
        return const Icon(Icons.circle_notifications,
            color: Color.fromARGB(255, 14, 129, 81), size: 40.0);

      case "Rejected":
        return const Icon(Icons.circle_notifications,
            color: Color.fromARGB(255, 193, 30, 30), size: 40.0);

      default:
        return const Icon(Icons.circle_notifications,
            color: Color.fromARGB(255, 198, 167, 11), size: 40.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("notification!.icon");
    print(notification!.status);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: getStatusIcon(notification!.status),

              title: Text(notification!.from,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Color.fromARGB(255, 0, 0, 0))),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      notification!.message,
                      style: const TextStyle(
                          fontSize: 15.0, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      notification!.datetime,
                      style: const TextStyle(
                          fontSize: 13.0,
                          color: Color.fromARGB(255, 109, 108, 108)),
                    ),
                  ),
                ],
              ),
              tileColor: const Color.fromARGB(255, 218, 249, 232),
              //trailing: ,
            ),
          ],
        ),
      ),
    );
  }
}
