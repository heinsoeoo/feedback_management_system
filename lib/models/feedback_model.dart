import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  String? id;
  String title;
  String description;
  String project;
  String email;
  Timestamp date;

  FeedbackModel({
    this.id,
    required this.title,
    required this.description,
    required this.email,
    required this.project,
    required this.date
  });

  static FeedbackModel fromJSON(DocumentSnapshot data) {
    return FeedbackModel(
      id: data.id,
      title: data['title'],
      description: data['description'],
      email: data['email'],
      project: data['project'],
      date: data['date']
    );
  }
}