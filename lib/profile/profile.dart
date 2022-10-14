import 'package:fdc_aj_quiz_app/helpers/app_constants.dart';
import 'package:fdc_aj_quiz_app/main.dart';
import 'package:fdc_aj_quiz_app/services/auth.dart';
import 'package:fdc_aj_quiz_app/services/firestore.dart';
import 'package:fdc_aj_quiz_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var report = ref.watch(reportStreamProvider);
    var user = AuthService().user;
    var total = 0;
    report.whenData((value) => total = value.total);
    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
          title: Text(user.displayName ?? 'Guest'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user.photoURL ?? 'https://s.gravatar.com/avatar/bc9b634a2ed0e5d1c3073291b6ce7b69?s=80'),
                  ),
                ),
              ),
              Text(user.email ?? 'Anonymous User', style: Theme.of(context).textTheme.headline6),
              const Spacer(),
              Text('$total', style: Theme.of(context).textTheme.headline2),
              Text('Quizzes Completed', style: Theme.of(context).textTheme.subtitle2),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.hexToColor(AppConstants.appPrimaryColorAction),
                ),
                onPressed: () {
                  FirestoreService().removeUserRecord();
                },
                child: const Text('reset results'),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.hexToColor(AppConstants.appPrimaryColorAction),
                ),
                onPressed: () {
                  if (mounted) {
                    Navigator.of(context).pushNamed('/profile/admin');
                  }
                },
                child: const Text('admin console'),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
                ),
                onPressed: () async {
                  await AuthService().signOut();
                  if (mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                  }
                },
                child: const Text('logout'),
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    } else {
      return const Loader();
    }
  }
}
