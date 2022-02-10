import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(LauncherApp());
}

class LauncherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '앱 실행기',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var apps = [];

  var _controller = TextEditingController(

  );

  String currentText = '';

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () async {
      apps = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: false,
      );
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "앱 실행기",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  onChanged: (text) {
                    setState(() {

                    });
                  },
                  decoration: InputDecoration(
                    border: null,
                    hintText: '앱 이름 입력',
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 9,
              child: ListView.builder(
                itemCount: apps.length,
                itemBuilder: (context, i) {
                  ApplicationWithIcon app = apps[i] as ApplicationWithIcon;
                  if (_controller.text.isNotEmpty && app.appName.contains(_controller.text) == false) {
                    return const SizedBox.shrink();
                  }

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          app.openApp();
                        },
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Stack(
                                    children: [
                                      AlertDialog(
                                        title: Row(
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Image.memory(app.icon),
                                            ),
                                            Flexible(
                                              flex: 5,
                                              child: Center(child: Text(app.appName)),
                                            ),
                                          ],
                                        ),
                                        content: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('패키지명', style: Theme.of(context).textTheme.headline5,),
                                              Text(app.packageName),
                                              const SizedBox(height: 8,),
                                              Text('카테고리명', style: Theme.of(context).textTheme.headline5,),
                                              Text(app.category.name),
                                              const SizedBox(height: 8,),
                                              Text('버전명', style: Theme.of(context).textTheme.headline5,),
                                              Text(app.versionName ?? ''),
                                              const SizedBox(height: 8,),
                                              Text('버전코드', style: Theme.of(context).textTheme.headline5,),
                                              Text('${app.versionCode}'),
                                              const SizedBox(height: 8,),
                                              Text('데이터 폴더 경로', style: Theme.of(context).textTheme.headline5,),
                                              Text('${app.dataDir}'),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          OutlinedButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: Text('확인'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        leading: Image.memory(apps[i].icon),
                        title: Text(
                          apps[i].appName,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          apps[i]?.versionName ?? '',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
/*

 ElevatedButton(onPressed: () async {
              var result = await LaunchApp.isAppInstalled(androidPackageName: '안드로이드 패키지명', iosUrlScheme: 'mobilenotes://');
              if (result == 1) LaunchApp.openApp(androidPackageName: '안드로이드 패키지명', iosUrlScheme: 'mobilenotes://', appStoreLink: '', openStore: false);
            }, child: Text("메모 앱")),
   */
}
