import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdc_aj_quiz_app/models/models.dart';
import 'package:fdc_aj_quiz_app/services/auth.dart';
import 'package:rxdart/rxdart.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> topicsStream = FirebaseFirestore.instance.collection('topics').snapshots();

  /// Retrieves a single quiz document
  Future<Quiz> getQuiz(String quizId) async {
    var ref = _db.collection('quizzes').doc(quizId);
    var snapshot = await ref.get();
    return Quiz.fromJson(snapshot.data() ?? {});
  }

  /// Listens to current user's report document in Firestore
  Stream<Report> streamReport() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('reports').doc(user.uid);
        return ref.snapshots().map((doc) => Report.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([Report()]);
      }
    });
  }

  /// Updates the current user's report document after completing quiz
  Future<void> updateUserReport(Quiz quiz) {
    var user = AuthService().user!;
    var ref = _db.collection('reports').doc(user.uid);
    var data = {
      'total': FieldValue.increment(1),
      'topics': {
        quiz.topic: FieldValue.arrayUnion([quiz.id]),
      },
    };
    return ref.set(data, SetOptions(merge: true));
  }

  Future<void> removeUserRecord() async {
    var user = AuthService().user!;
    _db.collection('reports').doc(user.uid).delete();
  }

  Future<void> removeTopic(String topicId) async {
    var collection = _db.collection('topics').doc(topicId);
    var topics = await collection.get();
    var topic = Topic.fromJson(topics.data()!);
    var quizzes = topic.quizzes;
    for (var quiz in quizzes) {
      removeQuiz(quiz.id);
    }
    await _db.collection('topics').doc(topicId).delete();
  }

  Future<void> removeQuiz(String quizId) async {
    _db.collection('quizzes').doc(quizId).delete();
  }
}
