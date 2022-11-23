import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../helpers/app_constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            const Text(
              'About Flutter Dev Camp...',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _launchURL(context),
              child: const Text('Show Flutter Dev Camp Web Site'),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  _launchURL(BuildContext context) async {
    const url = 'https://www.flutterdevcamp.com/';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Unable to Open URL'),
            content: const Text(
                'The device has not been able to open the URL: \n\nhttps://www.flutterdevcamp.com/\n\nYou can try to open the browser and navigate manually!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
    }
  }
}
