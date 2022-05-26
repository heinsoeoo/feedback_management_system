import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_management_system/controllers/auth_controller.dart';
import 'package:feedback_management_system/models/project_model.dart';
import 'package:feedback_management_system/screens/project_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Projects extends StatefulWidget {
  final String email;
  const Projects({Key? key, required this.email}) : super(key: key);

  @override
  State<Projects> createState() => _ProjectsState(this.email);
}

class _ProjectsState extends State<Projects> {
  late String email;
  _ProjectsState(this.email);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: StreamBuilder<List<ProjectModel>>(
        stream: getProjects(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          }else if (snapshot.hasData)  {
            final projects = snapshot.data!;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  toolbarHeight: 70,
                  expandedHeight: h*0.25,
                  backgroundColor: Colors.deepPurple,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text("Projects"),
                    titlePadding: EdgeInsets.only(left: 25, bottom: h*0.03),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        AuthController.instance.logout();
                      },
                      child: const Icon(
                          Icons.logout_outlined
                      ),
                    ),
                    SizedBox(width: 25)
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: SizedBox(
                      height: h*0.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome $email",
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: Text(
                              "The following projects were developed from our company",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.withOpacity(0.8)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  delegate: SliverChildBuilderDelegate((BuildContext context, index) {
                    final project = projects[index];
                    final id = project.id;
                    final name = project.name;
                    final logo = project.logo;
                    final email = this.email;

                    return Padding(
                      padding: EdgeInsets.all(20),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(()=>ProjectDetail(id: id, name: name, logo: logo, email: email,));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  offset: const Offset(0, 5),
                                  color: Colors.grey.withOpacity(0.2),
                                )
                              ]
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Spacer(),
                                Container(
                                  width: w*0.2,
                                  height: w*0.2,
                                  child: Image.network(
                                    logo
                                  )
                                ),
                                Spacer(),
                                Text(
                                  name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                    childCount: projects.length,
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }

  Stream<List<ProjectModel>> getProjects() => FirebaseFirestore.instance.collection('projects')
                                              .snapshots()
                                              .map((snapshot) =>
                                                snapshot.docs.map((doc) => ProjectModel.fromJSON(doc)).toList());
}