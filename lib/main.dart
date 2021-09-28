import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(LauncherApp());
}

class LauncherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '앱 실행기',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter App Test", style: TextStyle(color: Colors.blue, fontSize: 30),),
            ElevatedButton(onPressed: () async {
              bool result = await LaunchApp.isAppInstalled(androidPackageName: '안드로이드 패키지명', iosUrlScheme: 'mobilenotes://');
              if (result) LaunchApp.openApp(androidPackageName: '안드로이드 패키지명', iosUrlScheme: '', appStoreLink: '', openStore: false);
            }, child: Text("메모 앱")),
            ElevatedButton(onPressed: () {}, child: Text("이동할 앱 2")),
          ],
        ),
      ),
    );
  }
}
