import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class PushNotification {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String> get fcmToken async => await _firebaseMessaging.getToken();

  Future<void> subscribe(String subscription) async {
    await _firebaseMessaging.subscribeToTopic("$subscription}").then(print);
  }
  Future<void> listen() async {
    // while open
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      print("Message : ${notification.title}");
    });
    // on open
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("MESSAGE OPENED :${event.notification.title}");
    });

    //background

  }
  Future<void> initialize() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    print("Notification Settings : ${settings.announcement}");
    this.listen();


  }
  init() async {
    await Firebase.initializeApp();
    print("Token : ${await fcmToken}");
    this.initialize();
  }
}