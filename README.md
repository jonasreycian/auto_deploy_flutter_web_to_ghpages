# CI/CD with Flutter Web and Github Pages

CI/CD is a means of delivering apps to clients more frequently by incorporating automation into the app development process.
Continuous integration, continuous delivery, and continuous deployment are the three key principles associated with CI/CD.

In these article, I'll demostrate on how to integrate CI/CD on your Flutter Web static project to Github Pages.

While making this article, I'm using this version:

```bash
[√] Flutter (Channel stable, 2.8.1, on Microsoft Windows [Version 10.0.22000.493], locale en-PH)
    • Flutter version 2.8.1 at C:\src\flutter
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
          sed -i 's/\/auto_/auto_/g' build/web/index.html

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
