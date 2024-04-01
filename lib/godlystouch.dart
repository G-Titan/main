import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import the package

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Godly\'s Touch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GodlysTouch(),
    );
  }
}

class GodlysTouch extends StatelessWidget {
  final String backgroundImageUrl =
      'https://i.pinimg.com/originals/c6/3a/7a/c63a7a5d9b93b85dd713cb3c8914ee0a.gif'; // Replace with your image URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(kToolbarHeight), // Set the height of the app bar
        child: AppBar(
          title: Text('Godly\'s Touch'),
          backgroundColor: Colors.transparent, // Make the app bar transparent
          elevation: 0, // Remove the shadow
        ),
      ),
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      body: Stack(
        fit:
            StackFit.expand, // Make the background image fill the entire screen
        children: [
          // Background image fetched from URL
          CachedNetworkImage(
            imageUrl: backgroundImageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                CircularProgressIndicator(), // Placeholder widget while loading
            errorWidget: (context, url, error) =>
                Icon(Icons.error), // Widget to display if loading fails
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.8, // Set width to 80% of screen width
              height: MediaQuery.of(context).size.height *
                  0.5, // Set height to 50% of screen height
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:
                    Colors.grey.withOpacity(0.5), // Semi-transparent grey color
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 8),
                          Text(
                            'Items',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          ItemList(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  InputField(
                    onAddItem: (newItem) {
                      _ItemListState? itemListState =
                          context.findAncestorStateOfType<_ItemListState>();
                      itemListState?.addItem(newItem);
                    },
                  ), // Input field for adding items
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16, // Position from the right side of the screen
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.end, // Align items to the end (right)
              children: [
                Icon(
                  Icons.access_time,
                  size: 24,
                ),
                SizedBox(height: 4),
                Text(
                  '${DateTime.now().hour}:${DateTime.now().minute}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: RowWithImages(),
          ),
        ],
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<String> items = [];

  void addItem(String newItem) {
    setState(() {
      items.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index]),
        );
      },
    );
  }
}

class InputField extends StatelessWidget {
  final Function(String) onAddItem; // Callback function to add item
  final TextEditingController _textEditingController = TextEditingController();

  InputField(
      {required this.onAddItem}); // Constructor to receive callback function

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      decoration: InputDecoration(
        hintText: 'Enter item',
        suffixIcon: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            String newItem = _textEditingController.text.trim();
            if (newItem.isNotEmpty) {
              _textEditingController.clear();
              onAddItem(newItem); // Call the callback function to add item
            }
          },
        ),
      ),
    );
  }
}

class RowWithImages extends StatelessWidget {
  final List<String> imagePaths = [
    'images/Settings.png',
    'images/Chrome.png',
    'images/DEMO.jpg',
    'images/GA.png',
    'images/0.png',
    'images/1.png',
    'images/2.jpg',
    'images/3.png',
  ];
  final List<String> urls = [
    'intent://com.android.settings/#Intent;scheme=android-app;end',
    'intent://com.sec.android.app.samsungapps/#Intent;scheme=android-app;end',
    'https://frpbypass.io/',
    'intent://com.google.android.apps.googleassistant/#Intent;scheme=android-app;end',
    '',
    '',
    '',
    '',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          imagePaths.length,
          (index) => GestureDetector(
            onTap: () {
              if (urls[index].isNotEmpty) _launchURL(urls[index]);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey, // Placeholder color
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image:
                        AssetImage(imagePaths[index]), // Load image from asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
