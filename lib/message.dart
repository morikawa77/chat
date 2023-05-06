import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? id;
  String? message;
  String? userid;
  Timestamp? datetime;

  Message(this.id, this.message, this.userid, this.datetime);
}