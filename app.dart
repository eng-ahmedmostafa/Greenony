/* This code is a Flutter app that provides different services for farmers such as crop information, market prices, and soil health. The app also includes a registration form for new users.

The app has four pages:

HomePage: contains two buttons, one to view the available services, and the other to navigate to the registration page.
ServicesPage: shows the available services as a list of options.
CropInfoPage: contains information about crops (coming soon).
MarketPricePage: shows the market prices for different crops (coming soon).
SoilHealthPage: includes a form to upload an image of soil analysis and some additional information about the soil.
The app uses different packages such as image_picker for selecting an image from the gallery, http for uploading the image to a server, and fluttertoast for displaying toast messages.

The app is written using Dart programming language and the Flutter framework. */

import 'dart:io'; // Importing the dart:io library for using input and output functionality
import 'package:flutter/material.dart'; // Importing the Flutter Material package
import 'package:image_picker/image_picker.dart'; // Importing the image_picker package for accessing device images
import 'package:http/http.dart' as http; // Importing the http package for making HTTP requests
import 'dart:convert'; // Importing the dart:convert library for encoding and decoding JSON data
import 'package:fluttertoast/fluttertoast.dart'; // Importing the Fluttertoast package for displaying toast notifications

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmer Services App', // Setting the app title
      theme: ThemeData(
        primarySwatch: Colors.green, // Setting the primary color swatch
      ),
      home: HomePage(), // Setting the home page to the HomePage widget
      debugShowCheckedModeBanner: false, // Disabling the debug banner
    );
  }
}
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Services App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Farmer Services App!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServicesPage()),
                );
              },
              child: Text('View Services'),
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

// A page that displays a list of available services
class ServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: ListView(
        children: <Widget>[
          // A list tile for crop information service
          ListTile(
            leading: Icon(Icons.agriculture),
            title: Text('Crop Information'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CropInfoPage()),
              );
            },
          ),
          // A list tile for market prices service
          ListTile(
            leading: Icon(Icons.money),
            title: Text('Market Prices'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MarketPricePage()),
              );
            },
          ),
          // A list tile for soil health service
          ListTile(
            leading: Icon(Icons.nature_people),
            title: Text('Soil Health'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SoilHealthPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

// A page that displays crop information (currently empty)
class CropInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Information'),
      ),
      body: Center(
        child: Text(
          'Coming soon!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

// A page that displays market prices (currently empty)
class MarketPricePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Market Prices'),
      ),
      body: Center(
        child: Text(
          'Coming soon!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

// A page that allows the user to take a picture and input soil health data
class SoilHealthPage extends StatefulWidget {
  @override
  _SoilHealthPageState createState() => _SoilHealthPageState();
}

class _SoilHealthPageState extends State<SoilHealthPage> {
  File _image;
  final picker = ImagePicker();
  String _soilType;
  String _phValue;
  String _nitrogenLevel;
  String _phosphorusLevel;

  // A function that uses the image picker to select an image from the device's gallery
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}

// Function to upload the soil analysis data to the server
Future uploadSoilAnalysis() async {
// The API endpoint to upload the soil analysis data
String apiUrl = 'http://example.com/uploadSoilAnalysis';

// Create a byte stream from the image file
var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));

// Get the length of the image file
var length = await _image.length();

// Create a URI object from the API endpoint
var uri = Uri.parse(apiUrl);

// Create a multipart request object to send the data to the server
var request = new http.MultipartRequest("POST", uri);

// Create a multipart file object from the image file
var multipartFile = new http.MultipartFile(
'image',
stream,
length,
filename: basename(_image.path),
);

// Add the multipart file to the request
request.files.add(multipartFile);

// Send the request to the server and wait for the response
var response = await request.send();

// Check if the response status code is 200 (OK)
if (response.statusCode == 200) {
print('Image uploaded');
var responseString = await response.stream.bytesToString();
var jsonData = json.decode(responseString);
if (jsonData['status'] == 'success') {
Fluttertoast.showToast(msg: 'Soil analysis uploaded successfully');
} else {
Fluttertoast.showToast(msg: 'Failed to upload soil analysis');
}
} else {
print('Failed to upload image');
}
}
// This class represents the Registration Page, a StatefulWidget that will manage the form state.
class RegistrationPage extends StatefulWidget {
@override
_RegistrationPageState createState() => _RegistrationPageState();
}

// This class represents the state of the RegistrationPage, and contains the form data.
class _RegistrationPageState extends State<RegistrationPage> {
final _formKey = GlobalKey<FormState>();
String _name;
String _email;
String _phone;

@override
Widget build(BuildContext context) {
// This Scaffold widget provides the basic visual structure of the Registration Page.
return Scaffold(
appBar: AppBar(
title: Text('Registration'),
),
body: Padding(
padding: EdgeInsets.all(16.0),
// This Form widget is used to manage the state of the form.
child: Form(
key: _formKey,
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
// This TextFormField is used to collect the user's name.
TextFormField(
validator: (value) {
if (value.isEmpty) {
return 'Please enter your name';
}
return null;
},
onSaved: (value) {
_name = value;
},
decoration: InputDecoration(
hintText: 'Name',
),
),
SizedBox(height: 20),
// This TextFormField is used to collect the user's email address.
TextFormField(
validator: (value) {
if (value.isEmpty) {
return 'Please enter your email address';
}
return null;
},
onSaved: (value) {
_email = value;
},
decoration: InputDecoration(
hintText: 'Email',
),
),
SizedBox(height: 20),
// This TextFormField is used to collect the user's phone number.
TextFormField(
validator: (value) {
if (value.isEmpty) {
return 'Please enter your phone number';
}
return null;
},
onSaved: (value) {
_phone = value;
},
decoration: InputDecoration(
hintText: 'Phone',
),
),
SizedBox(height: 20),
// This RaisedButton is used to submit the form.
RaisedButton(
onPressed: () {
// This checks if the form is valid before saving the data and submitting the form.
if (_formKey.currentState.validate()) {
_formKey.currentState.save();
registerFarmer();
}
},
child: Text('Register'),
),
],
),
),
),
);
}
}
// This function sends a POST request to register a new farmer with the provided data
Future registerFarmer() async {
  // Set the API URL
  String apiUrl = 'http://example.com/registerFarmer';

  // Send a POST request with the farmer's data
  var response = await http.post(apiUrl, body: {
    'name': _name,
    'email': _email,
    'phone': _phone,
  });

  // Check if the response was successful
  if (response.statusCode == 200) {
    print('Farmer registered');

    // Parse the response body
    var responseString = response.body;
    var jsonData = json.decode(responseString);

    // Show a toast message based on the response status
    if (jsonData['status'] == 'success') {
      Fluttertoast.showToast(
        msg: 'Soil analysis uploaded successfully!',
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Failed to upload soil analysis. Please try again later.',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  // Check if the response was successful
  if (response.statusCode == 200) {
    // Parse the response body
    var jsonData = json.decode(response.body);

    // Show a toast message based on the response status
    if (jsonData['success'] == 1) {
      Fluttertoast.showToast(
        msg: 'Soil analysis uploaded successfully!',
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // Clear the form fields and image after successful upload
      setState(() {
        _soilType = '';
        _phValue = '';
        _nitrogenLevel = '';
        _phosphorusLevel = '';
        _image = null;
      });
    } else {
      Fluttertoast.showToast(
        msg: 'Failed to upload soil analysis. Please try again later.',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  } else {
    Fluttertoast.showToast(
      msg: 'Failed to upload soil analysis. Please try again later.',
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Upload Soil Analysis'), // App bar with title 'Upload Soil Analysis'
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Upload Soil Analysis', // Title text 'Upload Soil Analysis'
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Soil Type', // Text form field for 'Soil Type' with label text
              ),
              onChanged: (value) {
                _soilType = value; // Update _soilType variable on text change
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'pH Value', // Text form field for 'pH Value' with label text
              ),
              onChanged: (value) {
                _phValue = value; // Update _phValue variable on text change
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nitrogen Level', // Text form field for 'Nitrogen Level' with label text
              ),
              onChanged: (value) {
                _nitrogenLevel = value; // Update _nitrogenLevel variable on text change
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phosphorus Level', // Text form field for 'Phosphorus Level' with label text
              ),
              onChanged: (value) {
                _phosphorusLevel = value; // Update _phosphorusLevel variable on text change
              },
            ),
            SizedBox(height: 20),
            _image == null
                ? Text('No image selected.') // Text widget 'No image selected.' when _image is null
                : Image.file(
                    _image,
                    height: 200,
                  ), // Image widget when _image is not null
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () {
                _uploadSoilAnalysis(); // Call _uploadSoilAnalysis function on button press
              },
              child: Text('Upload Soil Analysis'), // Button text 'Upload Soil Analysis'
            ),
          ],
        ),
      ),
    ),
  );
}
