import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_management_system/models/feedback_model.dart';
import 'package:feedback_management_system/screens/feedback_editor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../models/feedback_model.dart';
import '../models/feedback_model.dart';

class ProjectDetail extends StatefulWidget {

  const ProjectDetail({Key? key, required this.id, required this.name, required this.logo, required this.email}) : super(key: key);

  final String id;
  final String name;
  final String logo;
  final String email;

  @override
  State<ProjectDetail> createState() => _ProjectDetailState(id, name, logo, email);
}

class _ProjectDetailState extends State<ProjectDetail> {
  late String id;
  late String name;
  late String logo;
  late String email;
  bool addFeedbackVisible=true;
  late double w, h;
  List<FeedbackModel> myFeedback = [];

  _ProjectDetailState(this.id, this.name, this.logo, this.email);

  @override
  Widget build(BuildContext context) {
    debugPrint("ProjectId: $id");
    debugPrint("email: $email");
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        // title: Text(
        //   "Project Detail"
        // ),
      ),
      body: StreamBuilder<List<FeedbackModel>>(
        stream: getFeedbacks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Column(
                children: [
                  SizedBox(height: 100),
                  Text('Something went wrong! ${snapshot.error}')
                ],
            );
          }else if (snapshot.hasData) {
            final feedbacks = snapshot.data!;
            if(feedbacks.length >= 1) {
              myFeedback = feedbacks.where((f) => f.email==email).toList();
              feedbacks.removeWhere((f) => f.email==email);
              if(myFeedback.length>=1) {
                addFeedbackVisible = (myFeedback[0].email == email) ? false : true;
              }
            }

            return Container(
              constraints: BoxConstraints(
                maxWidth: w,
                maxHeight: h,
              ),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: Column(
                  children: [
                    Container(height: h*0.08, color: Colors.deepPurple),
                    Container(
                      height: h*0.20,
                      color: Colors.deepPurple,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Image.network(
                                    logo,
                                    loadingBuilder: (BuildContext context, Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Image(
                                        image: AssetImage('images/loading.gif'),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Expanded(
                                    child: Text(
                                      "This project is about $name",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: (feedbacks.length >= 1)?ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: feedbacks.length,
                            itemBuilder: (BuildContext context, i) {
                              if (i==0 && myFeedback.length>=1) {
                                debugPrint("MyFeedMail: "+myFeedback[0].email);
                                debugPrint("MyAuthMail: "+email);
                                debugPrint(addFeedbackVisible.toString());
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 6),
                                      child: Card(
                                        elevation: 0,
                                        color: Colors.grey.withOpacity(0.2),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 13),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      myFeedback[0].title,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w800,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      DateFormat('MMMMd').format(myFeedback[0].date.toDate()),
                                                      textAlign: TextAlign.right,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: w,
                                                child: Text(
                                                  myFeedback[0].email,
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                myFeedback[0].description,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              getActions(
                                                  myFeedback[0].email,
                                                  email,
                                                  myFeedback[0].id,
                                                  myFeedback[0].title,
                                                  myFeedback[0].description,
                                                  myFeedback[0].project
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 6),
                                      child: Card(
                                        elevation: 0,
                                        color: Colors.grey.withOpacity(0.2),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 13),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      feedbacks[i].title,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w800,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      DateFormat('MMMMd').format(feedbacks[i].date.toDate()),
                                                      textAlign: TextAlign.right,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: w,
                                                child: Text(
                                                  feedbacks[i].email,
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                feedbacks[i].description,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              getActions(
                                                  feedbacks[i].email,
                                                  email,
                                                  feedbacks[i].id,
                                                  feedbacks[i].title,
                                                  feedbacks[i].description,
                                                  feedbacks[i].project
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                child: Card(
                                  elevation: 0,
                                  color: Colors.grey.withOpacity(0.2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 13),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                feedbacks[i].title,
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                DateFormat('MMMMd').format(feedbacks[i].date.toDate()),
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: w,
                                          child: Text(
                                            feedbacks[i].email,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          feedbacks[i].description,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        getActions(
                                            feedbacks[i].email,
                                            email,
                                            feedbacks[i].id,
                                            feedbacks[i].title,
                                            feedbacks[i].description,
                                            feedbacks[i].project
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                        ): Center(
                          child: Text(
                            "No feedback for this project!"
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: addFeedbackVisible,
                      child: SizedBox(
                        width: w,
                        height: h*0.08,
                        child: OutlinedButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.2)),
                          ),
                          onPressed: () {
                            Get.to(()=>FeedbackEditor(
                              appTitle: "Write Feedback",
                              id: '',
                              title: '',
                              description: '',
                              projectId: id,
                              email: email,
                            ));
                          },
                          child: Text(
                            "Write feedback for this project",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }else {
            return Center(child: CircularProgressIndicator());
          }
      })
    );
  }

  Stream<List<FeedbackModel>> getFeedbacks() => FirebaseFirestore.instance.collection('feedbacks')
      .where('project', isEqualTo: id)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => FeedbackModel.fromJSON(doc)).toList());

  Widget getActions(primary, secondary, fbackId, fbackTitle, fbackDesc, fbackProject) {
    if (primary==secondary) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.grey),
                overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.2)),
              ),
              onPressed: () {
                Get.to(()=>FeedbackEditor(
                    appTitle: "Edit Feedback",
                    id: fbackId,
                    title: fbackTitle,
                    description: fbackDesc,
                    projectId: fbackProject,
                    email: email
                ));
              },
              child: Text(
                  "Edit"
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: OutlinedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.grey),
                overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.2)),
              ),
              onPressed: () {
                setState(() {
                  _deleteFeedback(fbackId);
                });
              },
              child: Text(
                  "Delete"
              ),
            ),
          ),
        ],
      );
    }
    else {
      return Text("");
    }
  }

  void _deleteFeedback(id) async{
    await FirebaseFirestore.instance.collection('feedbacks')
      .doc(id)
      .delete()
      .then((value) => {
        Get.snackbar(
          "Delete Feedback",
          "Operation message",
          backgroundColor: Colors.green.withOpacity(0.9),
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Feedback deleted",
          ),
          messageText: Text(
            "Feedback deleted successfully",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        addFeedbackVisible = true
      });
  }
}


