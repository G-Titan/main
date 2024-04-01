import 'package:flutter/material.dart';
import 'package:cloud_os/godlystouch.dart';

void main() => runApp(CloudOSApp());

class CloudOSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud OS',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CloudOSHomePage(),
    );
  }
}

class CloudOSHomePage extends StatefulWidget {
  @override
  _CloudOSHomePageState createState() => _CloudOSHomePageState();
}

class _CloudOSHomePageState extends State<CloudOSHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cloud OS'),
      ),
      body: Center(
        child: Column(
          // Align children in the center of the main axis.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Cloud OS',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
                height: 20), // Add some space between the text and the buttons
            Row(
              // Align buttons in the center of the Row.
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Add your first button action here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GodlysTouch()),
                    );
                  },
                  child: Text('Launch OS'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Colors.deepPurple, // Button text color (white)
                  ),
                ),
                SizedBox(width: 20), // Add some space between the two buttons
                ElevatedButton(
                  onPressed: () {
                    // Add your second button action here
                    print('Second Button pressed');
                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor:
                        Colors.deepPurple, // Button background (purple)
                    backgroundColor: Colors.white, // Button text color (white)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
