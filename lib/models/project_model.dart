import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  String id;
  String name;
  String logo;

  ProjectModel({required this.id, required this.name, required this.logo});

  static ProjectModel fromJSON(DocumentSnapshot data) {
    return ProjectModel(
      id: data.id,
      name: data['name'],
      logo: data['logo'],
    );
  }
}