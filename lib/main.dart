import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

const String _markdownData = """
# CI/CD with Flutter Web and Github Pages

CI/CD is a means of delivering apps to clients more frequently by incorporating automation into the app development process.
Continuous integration, continuous delivery, and continuous deployment are the three key principles associated with CI/CD.

In these article, I'll demostrate on how to integrate CI/CD on your Flutter Web static project to Github Pages.

While making this article, I'm using this version:

```bash
[√] Flutter (Channel stable, 2.8.1, on Microsoft Windows [Version 10.0.22000.493], locale en-PH)
    • Flutter version 2.8.1 at C:\\src\\flutter
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision 77d935af4d (2 months ago), 2021-12-16 08:37:33 -0800
    • Engine revision 890a5fca2e
    • Dart version 2.15.1
```

---

## Create a Flutter Project

First, we have to create a flutter project. So open you terminal and execute the following command:

```cli
flutter create cicd_flutter_web_demo
```

This will create a new folder called `cicd_flutter_web_demo` in your current directory.
Go to the `cicd_flutter_web_demo` folder and execute the following command:

```cli
flutter run -d chrome
```

This will open a new browser with the Flutter Web application. Now we can confirm that the web application is working.

Now, let's build the project and see its directory.

```bash
ls build
```

---

## Create a Github Repository

- Now we have to create a Github repository. So open your browser and go to your Github account and create a new repository.
- The name of the repository should be `cicd_flutter_web_demo` or anything.
  Now we have to add the `cicd_flutter_web_demo` folder to the Github repository.

```cli
git remote add <github_repo>
```

## Create a Github Actions (CI/CD)

1. First, we copy the ff code snippet

```yaml
name: Build and Deploy

on:
  workflow_dispatch:
  push:
    branches: [master]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Clone Flutter repository with stable channel
        uses: subosito/flutter-action@4389e6cbc6cb8a4b18c628ff96ff90be0e926aa8
        with:
          version: stable
      - run: flutter doctor -v

      - name: Install dependencies
        run: flutter pub get

      - name: Build the project
        run: |
          flutter build web --release --base-href //auto_deploy_flutter_web_to_ghpages/
          sed -i 's/\\/auto_/auto_/g' build/web/index.html

      - name: Copy the build and deploy to GitHub pages
        run: |
          cp -r build/web/* docs
          git config user.name __YOUR_NAME_HERE__
          git config user.email __YOUR_EMAIL_HERE__
          git add .
          git commit -m 'Deploy'
          git push origin HEAD --force
          rm -r build
```
""";

void main() {
  runApp(const MyApp(
    mk: _markdownData,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required String mk,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(),
      home: const MarkdownWidget(
        mk: _markdownData,
      ),
    );
  }
}

class MarkdownWidget extends StatelessWidget {
  const MarkdownWidget({
    Key? key,
    required String mk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Markdown(
        data: _markdownData,
        shrinkWrap: true,
        softLineBreak: true,
        padding: const EdgeInsets.all(8),
        extensionSet: md.ExtensionSet(
          md.ExtensionSet.gitHubFlavored.blockSyntaxes,
          [
            md.EmojiSyntax(),
            ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
          ],
        ),
      ),
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
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'CI/CD with Flutter Web and Github Pages',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'By: Jonas Reycian Saraosos',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const Text(
                    'First, we have to create a flutter project. So open you terminal and execute the following command:'),
                const Text('flutter create cicd_flutter_web_demo'),
                const Text(
                    'This will create a new folder called cicd_flutter_web_demo in your current directory.'),
                const Text(
                    'Go to the cicd_flutter_web_demo folder and execute the following command:'),
                const Text('flutter run -d chrome'),
                const Text(
                    'This will open a new window with the Flutter Web application.'),
                const Text(
                    'Now we have to create a Github repository. So open your browser and go to your Github account and create a new repository.'),
                const Text(
                    'The name of the repository should be cicd_flutter_web_demo.'),
                const Text(
                    'Now we have to add the cicd_flutter_web_demo folder to the Github repository.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
