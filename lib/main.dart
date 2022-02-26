import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'CI/CD with Flutter Web and Github Pages',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                  'First, we have to create a flutter project. So open you terminal and execute the following command:'),
              Text('flutter create cicd_flutter_web_demo'),
              Text(
                  'This will create a new folder called cicd_flutter_web_demo in your current directory.'),
              Text(
                  'Go to the cicd_flutter_web_demo folder and execute the following command:'),
              Text('flutter run -d chrome'),
              Text(
                  'This will open a new window with the Flutter Web application.'),
              Text(
                  'Now we have to create a Github repository. So open your browser and go to your Github account and create a new repository.'),
              Text(
                  'The name of the repository should be cicd_flutter_web_demo.'),
              Text(
                  'Now we have to add the cicd_flutter_web_demo folder to the Github repository.'),
            ],
          ),
        ),
      ),
    );
  }
}
