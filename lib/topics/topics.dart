import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../helpers/app_constants.dart';
import '../services/firestore.dart';
import '../models/models.dart';
import '../shared/shared.dart';
import 'drawer.dart';
import 'topic_item.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreService().topicsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          List<Topic> topicsList = [];
          snapshot.data!.docs.map((DocumentSnapshot s) {
            Map<String, dynamic> a = s.data() as Map<String, dynamic>;
            topicsList.add(Topic.fromJson(a));
          }).toList();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
              title: const Text('Topics'),
              actions: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.circleUser,
                    color: AppConstants.hexToColor(AppConstants.appPrimaryColorLight),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/profile'),
                )
              ],
            ),
            drawer: TopicDrawer(topics: topicsList),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: topicsList.map((topic) => TopicItem(topic: topic)).toList(),
            ),
            bottomNavigationBar: const BottomNavBar(),
          );
        } else {
          return const Text('No topics found in Firestore. Check database');
        }
      },
    );
  }
}
