import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdc_aj_quiz_app/helpers/app_constants.dart';
import 'package:fdc_aj_quiz_app/models/models.dart';
import 'package:fdc_aj_quiz_app/services/firestore.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
        title: const Text('Admin Console'),
      ),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Select a Topic to Delete',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                      'The dropdown below will list all available topics, select one and to remove confirm the deletion by checking the check box and clicking Delete Topic.'),
                  StreamBuilder(
                      stream: FirestoreService().topicsStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return SizedBox(
                            height: 50,
                            child: Center(child: Text('Error: ${snapshot.error.toString()}')),
                          );
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          return const SizedBox(
                            height: 50,
                            child: Center(child: CircularProgressIndicator.adaptive()),
                          );
                        }
                        List<Topic> topicsList = [];
                        snapshot.data!.docs.map((DocumentSnapshot s) {
                          Map<String, dynamic> a = s.data() as Map<String, dynamic>;
                          topicsList.add(Topic.fromJson(a));
                        }).toList();
                        if (topicsList.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: Text(
                              'No Topics to display!!',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: ((context, index) => const Divider()),
                              itemCount: topicsList.length,
                              itemBuilder: ((context, index) {
                                return Dismissible(
                                  key: UniqueKey(),
                                  background: Container(
                                    alignment: Alignment.centerRight,
                                    color: Colors.green[800],
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 16.0),
                                      child: Text(
                                        'Delete topic',
                                        style: TextStyle(color: Color(0xFFFFFFFF)),
                                      ),
                                    ),
                                  ),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (_) {
                                    FirestoreService().removeTopic(topicsList[index].id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
                                        content: const Text(
                                          'Topic Deleted!',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        duration: const Duration(milliseconds: 1000),
                                      ),
                                    );
                                  },
                                  confirmDismiss: (_) async {
                                    return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Confirm Deletion'),
                                          content: const Text('Deleting the Topic automatically removes all associated Quizzes and cannot be undone!'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, true);
                                              },
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                              ),
                                              child: const Text('Delete'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, false);
                                              },
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                              ),
                                              child: const Text('Cancel'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(topicsList[index].title),
                                    trailing: const Icon(Icons.arrow_left),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 24),
                            const Text('Swipe and confirm to delete a topic! This action cannot be undone!'),
                            const SizedBox(height: 24),
                            const SizedBox(height: 24),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem> buildTopicMenuItems(List<Topic> data) {
    List<DropdownMenuItem> list = [];
    for (var topic in data) {
      list.add(
        DropdownMenuItem(
          value: topic.title,
          child: Text(topic.title),
        ),
      );
    }
    return list;
  }
}
