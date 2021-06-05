import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotification extends StatefulWidget {
  @override
  _PushNotificationState createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {

  //create a local notification object
  FlutterLocalNotificationsPlugin localNotifications;
  @override
  void initState()
  {
    super.initState();
    var androidInitialize=new AndroidInitializationSettings('ic_launcher');
    //this fct is to initialize android setting it takes as a paremeter icon name
    var initializationSettings=new InitializationSettings(
      android: androidInitialize
    );
    localNotifications=new FlutterLocalNotificationsPlugin();
    localNotifications.initialize(initializationSettings);

  }


 Future showNotification()async
  {
    var androidDetails=new AndroidNotificationDetails(
      "channelId",
      "Local Notification",
      "This is the description of the Notificaiton , you can write anyhing",
      importance: Importance.high
    );

    var generalNotificationDetails= new NotificationDetails(android: androidDetails);
    await localNotifications.show(0,
        "Taxi Bibi","You have a new request",
        generalNotificationDetails);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Center(
            child: Text("click here to receive a notificationss"),

          ),
      floatingActionButton: FloatingActionButton(
        onPressed: showNotification,
        child: Icon(Icons.notifications),
      ),

      );

  }
}
