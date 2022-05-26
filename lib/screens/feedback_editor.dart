import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class FeedbackEditor extends StatefulWidget {
  final String appTitle;
  final String id;
  final String title;
  final String description;
  final String projectId;
  final String email;

  const FeedbackEditor({Key? key,
    required this.appTitle,
    required this.id,
    required this.title,
    required this.description,
    required this.projectId,
    required this.email
  }) : super(key: key);

  @override
  State<FeedbackEditor> createState() => _FeedbackEditorState(appTitle, id, title, description, projectId, email);
}

class _FeedbackEditorState extends State<FeedbackEditor> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late String appTitle;
  late String id;
  late String title;
  late String description;
  late String projectId;
  late String date;
  late String email;

  _FeedbackEditorState(this.appTitle, this.id, this.title, this.description, this.projectId, this.email);

  @override
  Widget build(BuildContext context) {

    titleController.text = title;
    descriptionController.text = description;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        toolbarHeight: 70,
        title: Text(appTitle),
        actions: [
          OutlinedButton(
            style: ButtonStyle(
              side: MaterialStateProperty.all(BorderSide.none),
              overlayColor: MaterialStateProperty.all(Colors.deepPurple.withOpacity(0.2)),
            ),
            child: Text(
              'POST',
              textScaleFactor: 1,
              style: TextStyle(
                color: Colors.white
              ),
            ),
            onPressed: () {
              setState(() {
                _saveUpdateFeedback(id);
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15, left: 20, right: 20),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: TextField(
                controller: titleController,
                onChanged: (value) {
                  updateTitle();
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusColor: Colors.deepPurple,
                  labelStyle: TextStyle(
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: TextField(
                minLines: 5,
                maxLines: null,
                controller: descriptionController,
                onChanged: (value) {
                  updateDescription();
                },
                decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusColor: Colors.deepPurple,
                  labelStyle: TextStyle(
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateTitle(){
    title = titleController.text;
  }

  // Update the description of Note object
  void updateDescription() {
    description = descriptionController.text;
  }

  void _saveUpdateFeedback(id) async{
    if (id=='') {
      FirebaseFirestore.instance.collection('feedbacks').add({
        'title': title,
        'description': description,
        'project': projectId,
        'date': DateTime.now(),
        'email': email
      }).then((value) =>
      {
        Get.back(),
        Get.snackbar(
          "Added Feedback",
          "Operation message",
          backgroundColor: Colors.green.withOpacity(0.9),
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Feedback submitted",
          ),
          messageText: Text(
            "Feedback submitted successfully",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        )
      });
    } else {
      FirebaseFirestore.instance.collection('feedbacks')
        .doc(id)
        .update({
        'title': title,
        'description': description,
        // 'project': projectId,
        'date': DateTime.now(),
        // 'email': email
      }).then((value) =>
      {
        Get.back(),
        Get.snackbar(
          "Updated Feedback",
          "Operation message",
          backgroundColor: Colors.green.withOpacity(0.9),
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Feedback updated",
          ),
          messageText: Text(
            "Feedback updated successfully",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        )
      });
    }
  }
}
