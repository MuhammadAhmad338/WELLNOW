import 'dart:math';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationServicesProvider with ChangeNotifier {
  bool _notificationState = false;
  int _selectedTime = 1;
  bool get notificationState => _notificationState;
  int get selectedTime => _selectedTime;

  //Constructor
  NotificationServicesProvider() {
    loadNotificationState();
  }

  //Load the notification state
  void loadNotificationState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _notificationState = prefs.getBool('switchValue') ?? false;
    notifyListeners();
  }


  // Here we are initializing the notificaitions
  void initializeNotifications() {
    AwesomeNotifications().initialize(
      "", // Required for Android
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Notification channel for basic tests',
          importance: NotificationImportance.High,
          playSound: true,
        ),
      ],
    );
  }

  //Show notification of the water
 void scheduleWaterReminder() async {
  if (_notificationState) { // Check if notifications are enabled
    bool permissionGranted = await AwesomeNotifications().isNotificationAllowed();
    if (!permissionGranted) {
      permissionGranted = await AwesomeNotifications().requestPermissionToSendNotifications();
    }
    if (permissionGranted) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: createUniqueId(), // Fix: Replace createUniqueId() with a unique ID value
          channelKey: 'basic_channel',
          title: 'Time to Drink Water!',
          body: 'Stay hydrated, take a sip now!',
        ),
      );
      // Schedule the notification to show at regular intervals
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: createUniqueId(), // Replace createUniqueId() with a unique ID value
          channelKey: 'basic_channel',
          title: 'Time to Drink Water!',
          body: 'Stay hydrated, take a sip now!',
        ),
        schedule: NotificationInterval(interval: _selectedTime * 60, repeats: true), // Set interval to 60 minutes
      );
    } else {
      print('Permission to send notifications was denied');
    }
  }
}

  //Update the time
  void updateSelectedTime(int newTime, BuildContext context) {
  if(!_notificationState) {
    _selectedTime = newTime;
    notifyListeners();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please disable notifications to change the time'),
      ),
    );  
  }
  }

  void changeNotificationState(bool value) async {
    _notificationState = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('switchValue', value);
    notifyListeners();

    if (!_notificationState) {
      // If notifications are disabled
      AwesomeNotifications().cancelAllSchedules();
    }
  }

  //Create a function to create a random unique number for the notification ID
  int createUniqueId() {
    Random random = Random();
    int randomNumber = random.nextInt(100000);
    print(randomNumber);
    return randomNumber;
  }

}
