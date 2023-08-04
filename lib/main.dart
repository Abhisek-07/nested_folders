import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/nested': (context) => NestedScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> screens = [];
  String appcode = "";
  late String appSign;

  void _addScreen(String name) {
    setState(() {
      screens.add(name);
    });
  }

  void getAppSign() async {
    appSign = await SmsAutoFill().getAppSignature;
    print(appSign);
  }

  void listenForCode() async {
    await SmsAutoFill().listenForCode();
  }

  @override
  void initState() {
    getAppSign();
    listenForCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await SmsAutoFill().listenForCode();
              },
              child: Text('send otp'),
            ),
            PinFieldAutoFill(
              decoration: BoxLooseDecoration(
                strokeColorBuilder:
                    PinListenColorBuilder(Colors.black, Colors.black26),
                bgColorBuilder: const FixedColorBuilder(Colors.white),
                strokeWidth: 2,
              ),
              autoFocus: true,
              cursor: Cursor(color: Colors.red, enabled: true, width: 1),
              currentCode: appcode,
              onCodeSubmitted: (code) {},
              codeLength: 6,
              onCodeChanged: (code) {
                print(code);
                setState(() {
                  appcode = code ?? "";
                });
              },
            ),
            // ListView.builder(
            //   itemCount: screens.length,
            //   itemBuilder: (context, index) {
            //     return ListTile(
            //       title: Text(screens[index]),
            //       onTap: () {
            //         Navigator.pushNamed(
            //           context,
            //           '/nested',
            //           arguments: {'name': screens[index]},
            //         );
            //       },
            //     );
            //   },
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String screenName = '';

        return AlertDialog(
          title: Text('Enter Screen Name'),
          content: TextField(
            onChanged: (value) {
              screenName = value;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _addScreen(screenName);
                Navigator.pop(context);
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }
}

class NestedScreen extends StatefulWidget {
  @override
  _NestedScreenState createState() => _NestedScreenState();
}

class _NestedScreenState extends State<NestedScreen> {
  List<String> nestedScreens = [];

  void _addNestedScreen(String name) {
    setState(() {
      nestedScreens.add(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String currentScreenName = args['name'];

    return Scaffold(
      appBar: AppBar(
        title: Text(currentScreenName),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: nestedScreens.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(nestedScreens[index]),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/nested',
                  arguments: {'name': nestedScreens[index]},
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNestedDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showNestedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String screenName = '';

        return AlertDialog(
          title: Text('Enter Screen Name'),
          content: TextField(
            onChanged: (value) {
              screenName = value;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _addNestedScreen(screenName);
                Navigator.pop(context);
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
